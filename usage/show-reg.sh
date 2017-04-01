
isTemplate(){
    s=$1
    if [[ "$s" =~ ^.+\.template$ ]];then
        echo "$s is template"
    else
        echo "$s is not a template"
    fi
}
s="jdbc.properties.template"
s1="jdbc.properties"


isTemplate "$s"
isTemplate "$s1"
