#!/bin/bash

# 设置代理证书路径
export X509_USER_PROXY="/publicfs/cms/user/yanghz416/PocketCoffea/x509up_u23240"

# 定义自定义运行时目录
export XDG_RUNTIME_DIR="/publicfs/cms/user/yanghz416/PocketCoffea"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

# 设置 Kerberos 凭据缓存路径
export KRB5CCNAME="FILE:${XDG_RUNTIME_DIR}/krb5cc"

# 进入工作目录
cd /publicfs/cms/user/yanghz416/PocketCoffea || { echo "目录切换失败！"; exit 1; }

# 加载 Apptainer 环境
export PATH="/cvmfs/oasis.opensciencegrid.org/mis/singularity/current/bin:$PATH"

# 设置线程限制（避免多线程冲突）
export OPENBLAS_NUM_THREADS=1
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export VECLIB_MAXIMUM_THREADS=1
export NUMBA_NUM_THREADS=1

# 检查 Apptainer 是否存在
if ! command -v apptainer &> /dev/null; then
  echo "错误: Apptainer 未找到！"
  exit 1
fi

# 运行容器任务
apptainer exec \
  -B /publicfs \
  -B /afs/ihep.ac.cn/users/y/yanghz416 \
  -B /publicfs/cms/user/yanghz416/PocketCoffea/pocket_coffea:/usr/local/lib/python3.11/site-packages/pocket_coffea \
  -B /cvmfs/cms.cern.ch \
  -B /tmp \
  -B "${XDG_RUNTIME_DIR}" \
  --env "X509_USER_PROXY=${X509_USER_PROXY}" \
  /cvmfs/unpacked.cern.ch/gitlab-registry.cern.ch/cms-analysis/general/pocketcoffea:lxplus-el9-stable \
  /bin/bash -c "source myPocket/bin/activate && runner --cfg VHccPoCo/cfg_VHbb_ZLL_527DYZZ.py -o output_vhbb_0528_DYZZ_2323 --ignore-grid-certificate  --voms-proxy "/publicfs/cms/user/yanghz416/PocketCoffea/x509up_u23240" --executor futures -s 4 2>&1 | tee output_vhbb_zll_job_ZH.log"

# apptainer shell -B /publicfs -B /afs/ihep.ac.cn/users/y/yanghz416 -B /publicfs/cms/user/yanghz416/PocketCoffea/pocket_coffea:/usr/local/lib/python3.11/site-packages/pocket_coffea -B /cvmfs/cms.cern.ch -B /tmp -B "${XDG_RUNTIME_DIR}" --env "X509_USER_PROXY=${X509_USER_PROXY}" /cvmfs/unpacked.cern.ch/gitlab-registry.cern.ch/cms-analysis/general/pocketcoffea:lxplus-el9-stable

####apptainer shell -B /eos -B /afs -B /cvmfs/cms.cern.ch  -B /tmp -B /eos/home-h/haozhong/PocketCoffea/pocket_coffea:/usr/local/lib/python3.11/site-packages/pocket_coffea -B /eos/cms/ -B /etc/sysconfig/ngbauth-submit   -B ${XDG_RUNTIME_DIR}  --env KRB5CCNAME="FILE:${XDG_RUNTIME_DIR}/krb5cc"        /cvmfs/unpacked.cern.ch/gitlab-registry.cern.ch/cms-analysis/general/pocketcoffea:lxplus-el9-stable
# cd /publicfs/cms/user/yanghz416/PocketCoffea

# source myPocket/bin/activate

# build-datasets --cfg samples_Run3_only_i_use.json -o -rs 'T[2]_(CN)_\w+' -ir
















# #!/bin/bash
# export X509_USER_PROXY=/publicfs/cms/user/yanghz416/PocketCoffea/x509up_u23240
# #export XDG_RUNTIME_DIR="/tmp/runtime_$(id -u)"
# # mkdir -p "$XDG_RUNTIME_DIR"
# # chmod 700 "$XDG_RUNTIME_DIR"

# # 更新 Kerberos 凭据缓存路径
# #export KRB5CCNAME="FILE:${XDG_RUNTIME_DIR}/krb5cc"
# #/tmp/x509up_u23240
# # 进入工作目录
# cd /publicfs/cms/user/yanghz416/PocketCoffea #|| exit 1

# # 加载 Apptainer/Singularity
# export PATH=/cvmfs/oasis.opensciencegrid.org/mis/singularity/current/bin:$PATH
# export OPENBLAS_NUM_THREADS=1
# export OMP_NUM_THREADS=1
# export MKL_NUM_THREADS=1
# export VECLIB_MAXIMUM_THREADS=1
# export NUMBA_NUM_THREADS=1
# # 检查命令是否存在
# which apptainer || { echo "apptainer 未找到！"; exit 1; }
# echo "XDG_RUNTIME_DIR 的当前值是: ${XDG_RUNTIME_DIR}"
# # 运行任务（使用 apptainer）     #--env XDG_RUNTIME_DIR="/run/user/$(id -u)"--env KRB5CCNAME="FILE:${XDG_RUNTIME_DIR}/krb5cc" -B "${XDG_RUNTIME_DIR}"
# apptainer exec \
#   -B /publicfs -B /afs/ihep.ac.cn/users/y/yanghz416 -B /cvmfs/cms.cern.ch -B /tmp   \
#   --env X509_USER_PROXY=$X509_USER_PROXY  \
#   /cvmfs/unpacked.cern.ch/gitlab-registry.cern.ch/cms-analysis/general/pocketcoffea:lxplus-el9-stable \
#   /bin/bash -c "source myPocket/bin/activate && runner  --cfg VHccPoCo/cfg_VHbb_ZLL.py -o output_vhbb_zll_ST --ignore-grid-certificate --skip-bad-files --voms-proxy "/publicfs/cms/user/yanghz416/PocketCoffea/x509up_u23240"   --executor futures -s 2 -lf 1 2>&1 | tee output_vhbb_zll_job_ST.log"
