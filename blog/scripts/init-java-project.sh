#!/bin/bash
mkdir -p $1
cd $1
mkdir -p src/main/{java,resources}
mkdir -p src/test/{java,resources}
mkdir scripts
mkdir -p lib/test
echo "# README" > README.md
curl https://gist.githubusercontent.com/mcgivrer/a31510019029eba73edf5721a93c3dec/raw/4ab33169131ac0c76018e98237e3d9e45f86d591/build.sh -o ./scripts/build.sh
curl https://gist.githubusercontent.com/mcgivrer/a31510019029eba73edf5721a93c3dec/raw/4ab33169131ac0c76018e98237e3d9e45f86d591/stub.sh -o ./lib/stub.sh
curl https://gist.githubusercontent.com/mcgivrer/a31510019029eba73edf5721a93c3dec/raw/4ab33169131ac0c76018e98237e3d9e45f86d591/options.txt -o ./lib/options.txt
curl https://gist.githubusercontent.com/mcgivrer/a31510019029eba73edf5721a93c3dec/raw/4ab33169131ac0c76018e98237e3d9e45f86d591/options.txt -o ./lib/options.txt
curl https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.8.2/junit-platform-console-standalone-1.8.2.jar -o ./lib/test/junit-platform-console-standalone-1.8.2.jar
echo target/ > .gitignore
git init
git flow init -f
echo "Project $1 created."
echo Please read the following instruction to use the build.sh scripts
open https://gist.github.com/mcgivrer/a31510019029eba73edf5721a93c3dec#file-readme-md
