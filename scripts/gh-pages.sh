#!/bin/bash -xe

#update repository config
repository=https://github.com/user/repo.git
path_build=docs/build/html

create_dir(){
    rm -rf $path_build;
    mkdir -p $path_build;
    cd $path_build;
}

git_init(){
    git init;
    git remote add origin $repository;
    git checkout --orphan gh-pages;
    git_commit;
}

git_clone_orphan(){
    git clone $repository app;
    mv app/{,.[^.]}* ./ && rm -rf app/;
    git checkout --orphan gh-pages;
    git_rm;
    git_commit;
}

git_clone_alternative(){
    git clone $repository app;
    mv app/{,.[^.]}* ./ && rm -rf app/;
    git checkout -b gh-pages;
    git_rm;
    git_commit;
}

git_clone(){
    git clone $repository app;
    mv app/{,.[^.]}* ./ && rm -rf app/;
    git branch gh-pages;
    git symbolic-ref HEAD refs/heads/gh-pages;
    git_rm;
    git_commit;
}

git_clone_production(){
    git clone $repository app;
    mv app/{,.[^.]}* ./ && rm -rf app/;
    git checkout -b gh-pages remotes/origin/gh-pages;
}

git_commit(){
    file_init;
    git add .;
    git commit -m "added .nojekyll/README.md/.gitignore";
    git push -u origin gh-pages;
}

git_rm(){
    rm .git/index;
    git clean -fdx;
}

gen_doc(){
    cd ../../;
    sphinx-quickstart;
}

file_init(){
    touch .nojekyll;
    echo -e "task-list-dev documentation\nmake html" > README.md;
    echo "*.buildinfo *.inv *.doctrees" | sed 's/ \+/\n/g' > .gitignore
}

main(){
    create_dir;
    eval $cmd;
    if ! [ $cmd == git_clone_production ]; then \
        gen_doc;
    fi
}

cmd=$1
main;
exit 0;
