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
        'Flask>=0.9',
        'Click>=6',
        'Flask-Login>=0.4',
        'Flask-WTF>=0.8',
        'Markdown>=2.2.0',
        'Pygments>=1.5',
        'WTForms>=1.0.2',
        'Werkzeug>=0.8.3'
    ],
    setup_requires=['pytest-runner'],
    tests_require=['pytest', 'mock'],
    entry_points={
        'console_scripts': [
            'wiki=wiki.cli:main'
        ]
    }
)
