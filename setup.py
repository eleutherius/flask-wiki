from setuptools import setup, find_packages


print(find_packages())

setup(
    name='flask-wiki',
    version='0.0.4',
    description='simple python markdown wiki with web UI',
    author='ALex Lyakhov',
    author_email='eleutherius69@gmail.com',
    # url='https://github.com/eleutherius/flask-wiki',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'Flask==2.0.2',
        'click==8.0.3',
        'Werkzeug==2.0.2',
        'Jinja2==3.0.3',
        'MarkupSafe==2.0.1',
        'Markdown==3.3.6',
        'WTForms==3.0.1',
        'Flask_Login==0.5.0',
        'Flask-WTF==1.0.0',
        'dataclasses==0.6',
        'typing-extensions==4.0.1'
    ],
    setup_requires=['pytest-runner'],
    tests_require=['pytest', 'mock'],
    entry_points={
        'console_scripts': [
            'wiki=wiki.cli:main'
        ]
    }
)
