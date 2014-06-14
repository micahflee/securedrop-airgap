#!/usr/bin/env python

import os, sys

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

version = open('version').read().strip()

setup(
    name='securedrop-airgap',
    version=version,
    description='',
    long_description="""""",
    author='Micah Lee',
    author_email='micah@pressfreedomfoundation.org',
    url='https://github.com/micahflee/securedrop-airgap',
    license="GPL v2",
    packages=['securedrop_airgap'],
    include_package_data=True,
    data_files = [
        ('/usr/share/applications', ['install/securedrop-airgap.desktop']),
        ('/usr/share/pixmaps', ['install/securedrop.png'])
    ],
    scripts = ['bin/securedrop-airgap']
)
