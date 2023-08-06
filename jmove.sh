#!/bin/sh

# ${parameter//pattern/string}使用string替换pattern
# 假设输入是a/b/c pattern= .*a.*b.*c[^/]*; c为最后一级目录
# 
# ${${1}//\//\.*}: 
#   ${1}: 表示第一个参数
#   //  : 是语法的分割符
#   \   : 转义字符
#   /   : pattern,要替换的字符串
#   /  : 分割符
#   \   : 转义字符
#   .*  : 替换后的字符串, .表示任意字符, *表示任意次数
pattern=.*${${1}//\//\.*}[^/]*
root=($(ls ~))
cur=$(pwd)
# 将find的结果转化为数组
cd ~
dirs=($(find ${root} ! -path "*.git*" -type d -iregex ${pattern}))
cd ${cur}
# dirs=($(find ${root} -type d -iregex ${pattern}))
#忽略.git目录

#如果数组的个数为0则返回失败
nums=${#dirs[@]}
suffic=none
#如果数组的个数为1则直接跳转
if [ ${nums} -eq 0 ]; then
    echo "no match path~"
elif [ ${nums} -eq 1 ]; then
    cd ~/${dirs[1]}
else
    for i in $(seq 1 ${nums})
    do
      if [[ ${dirs[$i]} != ${suffic}* ]];then
        echo "$i: ${dirs[$i]}"
        suffic=${dirs[$i]} 
      fi
    done
    echo -n "select your target path: "
    read index
    cd ~/${dirs[$index]}
fi

