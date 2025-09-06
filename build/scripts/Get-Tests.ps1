$output = p check --list-tests
$tests = @{ testcases = $output | Where-Object { $_.StartsWith("tc") } | Select-Object -Unique }

if($env:CI) {
    Write-Output -InputObject (ConvertTo-Json -InputObject $tests -Depth 100 -Compress) >> $env:GITHUB_OUTPUT
}
