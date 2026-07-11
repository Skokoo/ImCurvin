from setuptools import setup, find_packages

setup(
    name="imcurvin",
    version="1.2.0",
    license='Apache 2.0',
    author="Skokoo",
    author_email="Skokoo@proton.me",
    description="Web security auditing tool with advanced evasion modes",
    
    long_description="""
ImCurvin is an open source, server friendly web security auditing tool built entirely on Termux for detecting environment misconfigurations, probing backend vulnerabilities, etc. It offers 3 modes: Default, Risk, and Defiance. 

Its peak performance lies in Defiance Mode powered by a dual vector parallel attack sequence that executes synchronized multi-threaded MySQL time-based injections while rotating multi-IP TOR circuits per request, and more! 

Check the repo to see the rest: https://github.com
For Modes detail:
https://github.com/Skokoo/ImCurvin/blob/main/Mode.md
    """,
    long_description_content_type="text/markdown",
    url="https://github.com/Skokoo/ImCurvin",
    project_urls={
        "Homepage": "https://github.com/Skokoo/ImCurvin",
    },
    packages=find_packages(),
    include_package_data=True,
    package_data={
        "": ["data/*.txt", "Imcurvin/*.sh", "Imcurvin/*.txt", "tamper/*.sh", "validators/*.py"],
    },
    scripts=["Imcurvin/imcurvin.sh"],
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Information Technology",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: POSIX :: Linux",
        "Programming Language :: Unix Shell",
        "Programming Language :: Python :: 3",
        "Topic :: Security",
    ],
    zip_safe=False,
)
