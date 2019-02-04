#!/bin/sh

# 假设输入是a/b/c pattern= .*a.*b.*c[^/]*; c为最后一级目录
pattern=.*${${1}//\//\.*}[^/]*

root=~
# 将find的结果转化为数组
dirs=($(find ${root} ! -path "*.git*" ! -path "*.local*" -type d -iregex ${pattern}))
# dirs=($(find ${root} -type d -iregex ${pattern}))
#忽略.git目录

#如果数组的个数为0则返回失败
nums=${#dirs[@]}

#如果数组的个数为1则直接跳转
if [ ${nums} -lt 2 ]; then
    cd ${dirs[1]}
else
  for i in $(seq 1 ${nums})
    do
        echo "$i: ${dirs[$i]}"
    done
    echo -n "select your target path: "
    read index
    cd ${dirs[$index]}
fi

