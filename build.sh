set -o errexit

pip install -r requirments.txt

python manage.py collectstatic --noinput

python manage.py makemigrations app
python manage.py migrate

# Create superuser if configured
python create_superuser.py

