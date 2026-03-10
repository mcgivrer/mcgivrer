#!/bin/bash
if [ $1 -eq ""]; then
#---- Display help message ---------------------------------------
    echo -e "Command line: $0

Usage:
-------

$0 -p [project_name] -a [author_name] -e [author_email] -v [project_version]

  - [project_name] name of the project directory to be generated (will be used capitalized as application name and main class),
  - [project_version] the version for the project to be initialized
  - [author_name] name of the author (used as commiter),
  - [author_email] email of the author (used as commiter)

---
"
else

#---- set variables for all files ---------------------------------------

    while getopts ":p:a:e:v:j:p" opt; do
        case $opt in
            p) PROJECT_NAME="$OPTARG"
            ;;
            a) AUTHOR="$OPTARG"
            ;;
            e) EMAIL="$OPTARG"
            ;;
            v) VERSION="$OPTARG"
            ;;
            j) JVERSION="$OPTARG"
            ;;
            \?) echo "Invalid option -$OPTARG" >&2
            exit 1
            ;;
        esac
        case $OPTARG in
            -*) echo "$opt need valid argument"
            exit 1
            ;;
        esac
    done
    # set parameters
    export JAVA_VERSION=$JVERSION
    export APP_VERSION=$VERSION
    export APP_PACKAGE_NAME="com.${PROJECT_NAME,,}.app"
    export APP_EXE=${PROJECT_NAME}
    export APP_NAME=${PROJECT_NAME}
    APP_NAME=( $APP_NAME )
    APP_NAME=${APP_NAME[@]^}
    export AUTHOR_NAME=${AUTHOR}
    export AUTHOR_EMAIL=${EMAIL}
    export LIBS=./lib

#---- prepare project file structure ---------------------------------------
    echo "|"
    echo "|_ Create project directory structure"
    mkdir $PROJECT_NAME
    cd $PROJECT_NAME
    mkdir -p ./src/main/{java,resources}
    mkdir -p ./src/test/{java,resources}
    mkdir -p $LIBS/test
    mkdir -p ./scripts/

    echo "|"
    echo "|_ Create Readme"
#---- start of README.md file ---------------------------------------
    cat > README.md << EOL
# README
   
this is the readme file for $1

$2
EOL

#---- end of README.md file ---------------------------------------

    echo "|"
    echo "|_ Create build file"

#---- start of build.sh file ---------------------------------------
curl https://gist.githubusercontent.com/mcgivrer/a31510019029eba73edf5721a93c3dec/raw/4ab33169131ac0c76018e98237e3d9e45f86d591/build.sh -o ./scripts/build.sh
curl https://gist.githubusercontent.com/mcgivrer/a31510019029eba73edf5721a93c3dec/raw/4ab33169131ac0c76018e98237e3d9e45f86d591/stub.sh -o ./lib/stub.sh
curl https://gist.githubusercontent.com/mcgivrer/a31510019029eba73edf5721a93c3dec/raw/4ab33169131ac0c76018e98237e3d9e45f86d591/options.txt -o ./lib/options.txt
curl https://gist.githubusercontent.com/mcgivrer/a31510019029eba73edf5721a93c3dec/raw/4ab33169131ac0c76018e98237e3d9e45f86d591/options.txt -o ./lib/options.txt
curl https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.8.2/junit-platform-console-standalone-1.8.2.jar -o ./lib/test/junit-platform-console-standalone-1.8.2.jar    

#---- end of build.sh file ---------------------------------------


    chmod +x ./scripts/build.sh
    echo "|"
    echo "|_ Create gitignore file"

#---- sart of .gitignore file ---------------------------------------
    cat > .gitignore << EOL
/.settings
/.vscode
/.idea
.classpath
.project
/target
**/*.class
EOL

#---- end of .gitignore file ---------------------------------------
    echo "|"
    echo "|_ Create app $APP_NAME main class in package ${APP_PACKAGE_NAME//.//}"
    mkdir -p src/main/java/${APP_PACKAGE_NAME//.//}
#---- start of main java class file ---------------------------------------
    cat > src/main/java/${APP_PACKAGE_NAME//.//}/${APP_NAME}App.java << EOL
package $APP_PACKAGE_NAME;
   
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

/**
 * main class for project ${APP_NAME}
 *
 * @author ${AUTHOR_NAME}
 * @since ${APP_VERSION}
 */
public class ${APP_NAME}App{

    private ResourceBundle messages = ResourceBundle.getBundle("i18n/messages");
    private Properties config = new Properties();
    private boolean exit = false;

    public ${APP_NAME}App(){
        System.out.println(String.format("Initialization application %s (%s)",
                messages.getString("app.name"),
                messages.getString("app.version")));    }

    public void run(String[] args){
        init(args);
        loop();
        dispose();
    }

    private void init(String[] args){
        List<String> lArgs = Arrays.asList(args);
        try {
            config.load(this.getClass().getResourceAsStream("/config.properties"));

            exit = Boolean.parseBoolean(config.getProperty("app.exit"));
        } catch (IOException e) {
            System.out.println(String.format("unable to read configuration file: %s", e.getMessage()));
        }

        lArgs.forEach(s -> {
            System.out.println(String.format("- arg: %s", s));
        });  
    }
    private void loop(){
        while(!exit){
            // will loop until exit=true or CTRL+C
        }
    }
    private void dispose(){
        System.out.println("End of application ${APP_NAME}");
    }

    public static void main(String[] argc){
        ${APP_NAME}App app = new ${APP_NAME}App();
        app.run(argc);
    }
}
EOL
#---- end of .gitignore file ---------------------------------------
    echo "|"
    echo "|_ Project $APP_NAME created."

    mkdir -p src/main/resources

#---- start of config.properties file ---------------------------------------
    cat > src/main/resources/config.properties << EOL
app.exit=true
EOL
#---- end of config.properties file ---------------------------------------
    mkdir -p src/main/resources/i18n

#---- start of default i18n/messages.properties file ---------------------------------------    
    cat > src/main/resources/i18n/messages.properties << EOL
app.name=${APP_NAME}
app.version=${VERSION}
EOL
#---- end of default i18n/messages.properties file ---------------------------------------

#---- create git repository ---------------------------------------
    echo "|"
    echo "|_ Initialize git repository and commit files with ${AUTHOR_NAME}<${AUTHOR_EMAIL}>"
    git init
    git config --local user.name "${AUTHOR_NAME}"
    git config --local user.email ${AUTHOR_EMAIL}
    git add .
    git commit -m "Create project ${APP_NAME}"
    echo "|"
    echo "|_ DONE !"
    echo "---"
fi
