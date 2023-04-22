call c:\python\miniconda3\Scripts\activate.bat
call activate book
pip install C:/data/Dave/Public/DAVE --use-feature=in-tree-build
del "C:\python\miniconda3\envs\book\Lib\site-packages\pyo3d.cp37-win_amd64.pyd"
copy "C:\data\vf\pyo3d\x64\Release\pyo3d.cp37-win_amd64.pyd" C:\python\miniconda3\envs\book\Lib\site-packages