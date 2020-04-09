from flask import Blueprint, request, render_template, redirect, url_for, flash, send_from_directory, send_file
from . import db
from flask_login import login_required, current_user
from .models import OriginalFiles, MappedFiles
from werkzeug.utils import secure_filename
import os
import hashlib

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return render_template('index.html')

@main.route('/profile')
@login_required
def profile():
    return render_template('profile.html', username=current_user.username)

@main.route('/upload')
@login_required
def upload():
    return render_template('upload.html', username=current_user.username)

def allowed_file(filename):
    ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@main.route('/upload', methods=['POST'])
@login_required
def upload_post():
    file = request.files['file']

    # get filename and folders
    file_name = secure_filename(file.filename)

    upload_folder = os.getcwd() + '/app/upload'
    
    if file.filename == '':
        return redirect(request.url)

    if file and allowed_file(file.filename):
        if not os.path.exists(upload_folder):
            os.makedirs(upload_folder, 777)

        complete_path = os.path.join(upload_folder, file_name)
        file.save(complete_path)

        file_hash = hashlib.md5()
        with open(complete_path, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                file_hash.update(chunk)
        
        filePresent = OriginalFiles.query.filter_by(md5=file_hash.hexdigest()).first()
        
        latestRowCount = OriginalFiles.query.count()
        
        if not filePresent: 
            uploadFile =  OriginalFiles(file_id=latestRowCount+1,fileName=file_name, md5=file_hash.hexdigest())
            mappedFile = MappedFiles(user_id=current_user.id, fileName=file_name, original_id=latestRowCount+1)
            db.session.add(uploadFile)
            db.session.add(mappedFile)
            db.session.commit()
        else:
            findFile = OriginalFiles.query.filter_by(md5=file_hash.hexdigest()).first()
            
            existsInMapped = MappedFiles.query.filter_by(user_id=current_user.id, original_id=findFile.file_id).first()
            
            if (not existsInMapped):
                mappedFile = MappedFiles(user_id=current_user.id, fileName=file_name, original_id=findFile.file_id)
                db.session.add(mappedFile)
                db.session.commit()

    return redirect(url_for('main.view'))


@main.route('/view')
@login_required
def view():
    uploadedFiles = MappedFiles.query.filter_by(user_id=current_user.id)
    return render_template('view.html', username=current_user.username, files=uploadedFiles)

@main.route('/download', methods=['GET','POST'])
@login_required
def download_file():
    if request.method == 'POST':
        mapped_id = request.form.get('mapped_id')
        upload_folder = os.getcwd() + '/app/upload'
        uploadedFiles = MappedFiles.query.filter_by(mapped_id=mapped_id).first()
        originalFiles = OriginalFiles.query.filter_by(file_id=uploadedFiles.original_id).first()
        upload_folder += '/' + originalFiles.fileName
        return send_file(upload_folder, as_attachment=True, attachment_filename=uploadedFiles.fileName)
    return redirect(url_for('main.view'))