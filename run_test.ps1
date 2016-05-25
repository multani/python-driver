Set-ExecutionPolicy Unrestricted
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -force
Get-ExecutionPolicy -List
echo $env:Path
Start-Process nosetests -ArgumentList "-s -v --with-ignore-docstrings --with-xunit --xunit-file=standard_results.xml .\tests\integration\standard\test_cluster.py:ClusterTests" -Wait -NoNewWindow -PassThru
echo "uploading results"
echo $env:APPVEYOR_JOB_ID
$wc = New-Object 'System.Net.WebClient'
$wc.UploadFile("https://ci.appveyor.com/api/testresults/junit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\standard_results.xml))
exit 0