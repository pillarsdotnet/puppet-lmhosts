# @summary Service codes for per-computer netbios services.
#
# This class provides reference variables.
#
# @see http://bit.ly/2J4CxvU
#
class lmhosts::host::service() {
  $dec_pathworks        = 0x4c
  $dec_pathworks_alt    = 0x52
  $exchange_directory   = 0x24
  $exchange_imc         = 0x6a
  $exchange_interchange = 0x22
  $exchange_mta         = 0x87
  $exchange_store       = 0x23
  $file_server          = 0x20
  $lotus_notes_server   = 0x2b
  $mcafee_antivirus     = 0x42
  $messenger            = 0x01
  $messenger_alt        = 0x03
  $modem_client         = 0x31
  $modem_server         = 0x30
  $netdde               = 0x1f
  $netmonitor_agent     = 0xbe
  $netmonitor_app       = 0xbf
  $ras_client           = 0x21
  $ras_server           = 0x06
  $sms_admin            = 0x44
  $sms_chat             = 0x45
  $sms_client           = 0x43
  $sms_transfer         = 0x46
  $workstation          = 0x00
}
