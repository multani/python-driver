Set-ExecutionPolicy Unrestricted
Get-ExecutionPolicy
echo $env:Path
powershell.exe -executionpolicy Unrestricted C:\Python27\Scripts\nosetests.exe -s -v --with-ignore-docstrings --with-xunit --xunit-file=standard_results.xml .\tests\integration\standard\test_cluster.py:ClusterTests
echo "uploading results"
echo $env:APPVEYOR_JOB_ID
$wc = New-Object 'System.Net.WebClient'
$wc.UploadFile("https://ci.appveyor.com/api/testresults/junit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\standard_results.xml))
exit 0