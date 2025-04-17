\href{http://afsapply.ihep.ac.cn/cchelp/zh/local-cluster/jobs/HTCondor/}{http://afsapply.ihep.ac.cn/cchelp/zh/local-cluster/jobs/HTCondor/}

```
cd /publicfs/cms/user/yanghz416/PocketCoffea
```
#proxy
```
export X509_USER_PROXY="/publicfs/cms/user/yanghz416/PocketCoffea/x509up_u23240"
```
#set kerberos path(设置 Kerberos 凭据缓存路径)
```
export XDG_RUNTIME_DIR="/publicfs/cms/user/yanghz416/PocketCoffea"

mkdir -p "$XDG_RUNTIME_DIR"

chmod 700 "$XDG_RUNTIME_DIR"

export KRB5CCNAME="FILE:${XDG_RUNTIME_DIR}/krb5cc"

voms-proxy-init -voms cms -rfc --valid 168:00

kinit

klist -c "$KRB5CCNAME"  #klist -c "FILE:${XDG_RUNTIME_DIR}/krb5cc"
ls -ld  ${XDG_RUNTIME_DIR}
```
#submit ihep condor job
```
export PATH=/afs/ihep.ac.cn/soft/common/sysgroup/hep_job/bin:$PATH
hep_sub -g cms   -os SL7 -mem 3000 -np 1  -argu "-f --use-ssl"  -o /publicfs/cms/user/yanghz416/PocketCoffea/  -e /publicfs/cms/user/yanghz416/PocketCoffea/job_test.err  ./job_ST.sh  #set -s 1  in job.sh

hep_q -u
```
