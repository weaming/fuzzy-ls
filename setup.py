# Always prefer setuptools over distutils
from setuptools import setup
import os
import re

here = os.path.abspath(os.path.dirname(__file__))


def read_text(fname):
    if os.path.isfile(fname):
        with open(os.path.join(here, fname)) as f:
            return f.read()
    else:
        print("warning: file {} does not exist".format(fname))
        return ""


def get_version(path):
    src = read_text(path)
    pat = re.compile(r"""^version = ['"](.+?)['"]$""", re.MULTILINE)
    result = pat.search(src)
    version = result.group(1)
    return version


long_description = read_text("README.md")
install_requires = [
    l
    for l in read_text("requirements.txt").split("\n")
    if l.strip() and not l.strip().startswith("#")
]

name = "fuzzy-path"
gh_repo = "https://github.com/weaming/{}".format(name)

setup(
    name=name,  # Required
    version=get_version("fuzzy_path.py"),  # Required
    description="List paths by chars composed by first letters of each levels",  # Required
    long_description=long_description,  # Optional
    long_description_content_type="text/markdown",  # Optional
    install_requires=install_requires,
    py_modules=['fuzzy_path'],
    entry_points={"console_scripts": ["fzpath=fuzzy_path:main"]},  # Optional
    url=gh_repo,  # Optional
    author="weaming",  # Optional
    author_email="garden.yuen@gmail.com",  # Optional
    keywords="developer,efficiency",  # Optional
    project_urls={"Bug Reports": gh_repo, "Source": gh_repo},  # Optional
)
