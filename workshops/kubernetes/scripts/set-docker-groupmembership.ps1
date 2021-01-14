param(
    [string]$username
)

Add-LocalGroupMember -Group "Administrators" -Member $username