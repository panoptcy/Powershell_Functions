<# 
@Author: Brandon C. Poole
@Author's Website: www.bcpoole.com
@Version: 1.0
@Dependencies: N/A
Purpose: List all local administrator accounts on a machine.
####################
# Change Log
####################
1.0 - New Script
 
####################
# Legal
####################
Copyright (c) 2016, Brandon C. Poole
Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.
THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#>
function Get-LocalAdmin {
<# 
   .SYNOPSIS 
    Returns all account in the local administrator group. 
     
   .DESCRIPTION
    Uses a WMI call to query all accounts in the local administrator group of a given computer.

   .PARAMETER ComputerName
    The name of the computer you wish to run the command on.

   .EXAMPLE
    Get-LocalAdmin -ComputerName "localhost"
    Returns all local administrator accounts on the local host.

#> 
    param(
        [Parameter(Mandatory=$true)][String]$ComputerName
    )

    $localAdmins = Get-WmiObject -ClassName win32_groupuser -ComputerName $ComputerName | Where-Object {$_.GroupComponent -like "*Administrator*"} 
    $localAdmins | ForEach-Object {
        $_.partcomponent –match “.+Domain\=(.+)\,Name\=(.+)$” > $nul  
        $matches[1].trim('"') + “\” + $matches[2].trim('"')
    } #End of for loop
}