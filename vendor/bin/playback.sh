set -x
# $1: device for output
#     spk: stereo speaker
#     top-spk: top speaker
#     bot-spk: bottom speaker
#     rcv: receiver
#     spk_hp: speaker high power
#     top-spk_hp: top speaker high power
#     bot-spk_hp: bottom speaker high power
#     rcv_hp: receiver high power
#     us: ultrasound

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh spk
# rcv.wav:-4.5dbfs   spk: -4.8dbfs  ultra: -4.5dbfs  spk_hp:-1.8dbfs

function enable_receiver
{
    echo "enabling receiver"
    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
    tinymix "PRIM_MI2S_RX Channels" "Two"
    tinymix "TFA Profile" "handset"
}

function disable_receiver
{
    echo "disabling receiver"
    tinymix "TFA Profile" "powerdown"
    tinymix "PRIM_MI2S_RX Channels" "Two"
    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
}

function enable_speaker
{
    echo "enabling speaker"
	tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
	tinymix "PRIM_MI2S_RX Channels" "Two"
	tinymix "TFA Profile" "stereo"
}

function disable_speaker
{
    echo "disabling speaker"
    tinymix "TFA Profile" "powerdown"
    tinymix "QUAT_MI2S_RX Channels" "Two"
    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
}

function enable_speaker_top
{
    echo "enabling speaker top"
    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
    tinymix "PRIM_MI2S_RX Channels" "Two"
    tinymix "TFA Profile" "left"
}

function disable_speaker_top
{
    echo "disabling speaker top"
    tinymix "TFA Profile" "powerdown"
    tinymix "PRIM_MI2S_RX Channels" "Two"
    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
}

function enable_speaker_bot
{
    echo "enabling speaker bottom"
    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 1
    tinymix "PRIM_MI2S_RX Channels" "Two"
    tinymix "TFA Profile" "right"
}

function disable_speaker_bot
{
    echo "disabling speaker bottom"
    tinymix "TFA Profile" "powerdown"
    tinymix "PRIM_MI2S_RX Channels" "Two"
    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" 0
}

function enable_ultrasound
{
    echo "enable ultrasound"

    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" "1"
    tinymix "PRIM_MI2S_RX Channels" "One"
    tinymix "PRIM_MI2S_RX Format" "S24_LE"
    tinymix "PRIM_MI2S_RX SampleRate" "KHZ_96"
    tinymix "TFA Profile" "handset"
}

function disable_ultrasound
{
    echo "disable ultrasound"
    tinymix "PRI_MI2S_RX Audio Mixer MultiMedia1" "0"
    tinymix "PRIM_MI2S_RX Channels" "Two"
    tinymix "PRIM_MI2S_RX Format" "S24_LE"
    tinymix "PRIM_MI2S_RX SampleRate" "KHZ_96"
    tinymix "TFA Profile" "powerdown"

}

if [ "$1" = "spk" ]; then
    enable_speaker
    filename=/vendor/etc/spk.wav
elif [ "$1" = "top-spk" ]; then
    enable_speaker_top
    filename=/vendor/etc/top_spk.wav
elif [ "$1" = "bot-spk" ]; then
    enable_speaker_bot
    filename=/vendor/etc/bottom_spk.wav
elif [ "$1" = "rcv" ]; then
    enable_receiver
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "spk_hp" ]; then
    enable_speaker
    filename=/vendor/etc/spk_hp.wav
elif [ "$1" = "top-spk_hp" ]; then
    enable_speaker_top
    filename=/vendor/etc/top_spk.wav
elif [ "$1" = "bot-spk_hp" ]; then
    enable_speaker_bot
    filename=/vendor/etc/bottom_spk_hp.wav
elif [ "$1" = "rcv_hp" ]; then
    enable_receiver
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "us" ]; then
    enable_ultrasound
    filename=/vendor/etc/ultrasound.wav
else
    echo "Usage: playback.sh device; device: spk or rcv or spk_hp or us"
fi

echo "start playing"
tinyplay $filename

if [ "$1" = "spk" ]; then
    disable_speaker
elif [ "$1" = "top-spk" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk" ]; then
    disable_speaker_bot
elif [ "$1" = "rcv" ]; then
    disable_receiver
elif [ "$1" = "spk_hp" ]; then
    disable_speaker
elif [ "$1" = "top-spk_hp" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk_hp" ]; then
    disable_speaker_bot
elif [ "$1" = "rcv_hp" ]; then
    disable_receiver
elif [ "$1" = "us" ]; then
    disable_ultrasound
fi

exit 0
