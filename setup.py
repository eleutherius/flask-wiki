from setuptools import setup, find_packages


print(find_packages())

setup(
    name='flask-wiki',
    version='0.0.3',
    description='simple python markdown wiki with web UI',
    author='ALex Lyakhov',
    author_email='eleutherius69@gmail.com',
    url='https://github.com/eleutherius/flask-wiki',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'alembic==0.9.9',
        'aniso8601==3.0.0',
        'click==6.7',
        'dominate==2.3.1',
        'Faker==0.8.8',
        'Flask==1.0.2',
        'Flask-Login==0.4.1',
        'Flask-Migrate==2.1.1',
        'Flask-RESTful==0.3.6',
        'Flask-Script==2.0.6',
        'Flask-SQLAlchemy==2.3.2',
        'Flask-Testing==0.7.1',
        'Flask-WTF==0.14.2',
        'itsdangerous==0.24',
        'Jinja2==2.10',
        'Mako==1.0.7',
        'Markdown==2.6.11',
        'MarkupSafe==1.0',
        'flask-marshmallow==0.9.0',
        'marshmallow==2.16.3',
        'marshmallow-sqlalchemy==0.13.2',
        'mixer==6.0.1',
        'python-dateutil==2.7.2',
        'python-editor==1.0.3',
        'python-slugify==1.2.5',
        'pytz==2018.4',
        'six==1.11.0',
        'SQLAlchemy==1.2.7',
        'text-unidecode==1.2',
        'Unidecode==1.0.22',
        'visitor==0.1.3',
        'Werkzeug==0.14.1',
        'WTForms==2.1' 
    ],
    setup_requires=['pytest-runner'],
    tests_require=['pytest', 'mock'],
    entry_points={
        'console_scripts': [
            'wiki=wiki.cli:main'
        ]
    }
)
