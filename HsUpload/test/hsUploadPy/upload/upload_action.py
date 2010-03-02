# system-related, third-party frameworks
import shutil
import os
import time

from django.http import HttpResponse
from django.shortcuts import render_to_response

# project
import settings

def ensure_dir(f):
    d = os.path.dirname(f)
    if not os.path.exists(d):
      os.makedirs(d)


def execute_action(request):
  print '1'
  if request.method == 'POST':
    print '2'
    return do_post(request)
    
  elif request.method == 'GET':
    print '3'
    return do_get(request)
    
def delete_action(request):
  queryDict = request.GET
  fileName = queryDict.get('fileName', '')
  os.remove(settings.UPLOADDIR + fileName)
  return write_response(fileName)

def do_get(request):
  queryDict = request.GET
  fileName = queryDict.get('fileName', '')
  image_data = open(settings.UPLOADDIR + fileName, "rb").read()
  return HttpResponse(image_data, mimetype="image/jpg")

def do_post(request):
  f = request.FILES['Filedata']

  ensure_dir(settings.UPLOADDIR)

  fileName = str(int(time.time() * 1000)) + '_' + f.name
  destination = open(settings.UPLOADDIR + fileName, 'wb+')
  
  for chunk in f.chunks():
    destination.write(chunk)
  destination.close()
  
  return write_response(fileName)

def write_response(fileName):
  response = HttpResponse('', mimetype='text/plain')
  response.write('<success file-name="' + fileName + '"/>')
  print response
  return response
  
def write_response_failed(f):
  response = HttpResponse('', mimetype='text/plain')
  response.write('<failed />')
  return response
