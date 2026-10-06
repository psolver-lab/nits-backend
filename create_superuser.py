#!/usr/bin/env python
"""Create a Django superuser if it doesn't exist."""
import os
import sys
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.contrib.auth.models import User

def create_superuser():
    username = os.getenv('SUPERUSER_USERNAME', 'admin')
    email = os.getenv('SUPERUSER_EMAIL', 'admin@example.com')
    password = os.getenv('SUPERUSER_PASSWORD', 'changeme123')
    
    if User.objects.filter(username=username).exists():
        print(f"Superuser '{username}' already exists.")
    else:
        User.objects.create_superuser(username, email, password)
        print(f"Superuser '{username}' created successfully!")

if __name__ == '__main__':
    create_superuser()

