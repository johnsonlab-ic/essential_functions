conda create -n tensorQTL python=3.11 cython jupyterlab ipykernel pytorch -c conda-forge
conda activate tensorQTL
pip3 install tensorqtl
conda install -c conda-forge pandas-plink

python -m ipykernel install --user --name myenv --display-name "tensorQTL"