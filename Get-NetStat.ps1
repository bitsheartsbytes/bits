function Get-NetStat
{
<#
.Synopsis
		This function will get the output of netstat -antop and parse the output
.Description
		This function will get the output of netstat -antop and parse the output
.Link
		This is inspired from the lazywinadmin github under tools section
		Link is not included in this script as i have no intention of calling back
		to his site.
#>

		PROCESS
		{
				# Get the output of netstat
				$data = netstat -antop
				
				#Keep only the line with the data (we remove the first lines)
				$data = $data[4..$data.count]
				
				#Each lin need to be splt and get rid of unnecessary spaces
				foreach ($line in $data)
				{
					#Get rid of first whitspaces, at the beginning of the line
					$line = $line -replace '^\s+', ''
					
					#Split each property on whitespaces block}
					$line = $line -split '\s+'
					
					#Define properties
					$properties = @{
						Protocol = $line[0]
						LocalAddressIP = ($line[1] -split ":")[0]
						LocalAddressPort = ($line[1] -split ":")[1]
						ForeignAddressIP = ($line[2] - split ":")[0]
						ForeignAddressPort = ($line[2] -split ":")[1]
						State = $line[3]
						}
						
						#Output current line
						New-Object -TypeName PSObject - Property $properties
					}
			}
}

