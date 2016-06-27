Set-StrictMode -Version "1.0"

[string]$drive = ""
[string]$fullDrive = ""
[string]$prompt = ""
[long]$filesChecked = 0
[long]$filesCompressed = 0
[long]$SizeBefore = 0
[long]$SizeAfter = 0

$drive = Read-Host -Prompt "Please enter the drive letter to scan: "
$drive = $drive.ToUpper()

[bool]$isNTFS = (Get-Volume -DriveLetter $drive).FileSystem -eq "NTFS"
if(!$isNTFS)
{
    "Drive is not using NTFS"
    "Aborting..."
    Exit
}

$SizeBefore = (Get-Volume -DriveLetter $drive).SizeRemaining
$SizeBefore = $SizeBefore / 1024
$SizeBefore = $SizeBefore / 1024
$SizeBefore = $SizeBefore / 1024

$prompt = Read-Host -Prompt "Are you sure you want to compress files on $($drive):\? [y/N]"

if ($prompt -ieq "y" -or $prompt -ieq "yes")
{
    $fulldrive = $drive + ":\"
    "Scanning drive $fulldrive ..."
    Foreach($file in Get-ChildItem -Name -Recurse -Attributes !Directory $fulldrive)
    {
        $fullPath = "$($fulldrive)$file"
        if((Get-Item $fullPath).Length -gt 5mb) 
        {
            "Compressing $fullPath"
            compact /c /f /q $fullPath > $null
            $filesCompressed += 1
        }
        $filesChecked += 1
    }

    $SizeAfter = (Get-Volume -DriveLeter $drive).SizeRemaining
    $SizeAfter = $SizeAfter / 1024
    $SizeAfter = $SizeAfter / 1024
    $SizeAfter = $SizeAfter / 1024
    ""
    "Summary:"
    "========"
    "`tFiles scanned: $filesChecked"
    "`tFiles compressed: $filesCompressed"
    "`tSize before: $($SizeBefore)GB"
    "`tSize after: $($SizeAfter)GB"
}
else
{
    "Aborting..."
    Exit
}
