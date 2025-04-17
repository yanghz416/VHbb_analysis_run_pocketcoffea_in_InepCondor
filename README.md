
[HTcondor](http://afsapply.ihep.ac.cn/cchelp/zh/local-cluster/jobs/HTCondor/)

```
cd /publicfs/cms/user/yanghz416/PocketCoffea
```
Make job.sh
```
ls -l job.sh

###if you see: "-rw-r--r-- 1 jiangxw u07 85 Aug 29 18:23 job.sh" ,then you need use 

chmod +x job.sh
```
Proxy
```
export X509_USER_PROXY="/publicfs/cms/user/yanghz416/PocketCoffea/x509up_u23240"
```
Set kerberos path(设置 Kerberos 凭据缓存路径)
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
Submit ihep condor job
```
export PATH=/afs/ihep.ac.cn/soft/common/sysgroup/hep_job/bin:$PATH
hep_sub -g cms   -os SL7 -mem 4000 -np 2  -argu "-f --use-ssl"  -o /publicfs/cms/user/yanghz416/PocketCoffea/  -e /publicfs/cms/user/yanghz416/PocketCoffea/job_test.err  ./job_ST.sh  #set -s 1  in job.sh

hep_q -u
```
