#!/bin/bash
set -e # Stop if error

sed '/^[[:blank:]]*#/d;/^\s*$/d' > /home/McMyAdmin/Minecraft/server.properties <<EOF
#Minecraft server properties
spawn-protection=16
max-tick-time=20000
generator-settings=
force-gamemode=false
allow-nether=true
gamemode=0
broadcast-console-to-ops=true
enable-query=false
player-idle-timeout=0
difficulty=$DIFFICULTY
spawn-monsters=$SPAWN_MONSTERS
op-permission-level=4
announce-player-achievements=true
pvp=$PVP_ENABLED
snooper-enabled=true
level-type=$LEVEL_TYPE
hardcore=false
enable-command-block=false
max-players=$MAX_PLAYERS
network-compression-threshold=256
resource-pack-sha1=
max-world-size=$MAX_WORLD_SIZE
server-port=$SERVER_PORT
server-ip=
spawn-npcs=true
allow-flight=true
level-name=$LEVEL_NAME
view-distance=10
resource-pack=
spawn-animals=true
white-list=false
generate-structures=true
online-mode=$ONLINE_MODE
max-build-height=256
level-seed=$LEVEL_SEED
use-native-transport=true
motd=$MOTD
enable-rcon=false

EOF

sed '/^[[:blank:]]*#/d;/^\s*$/d' > /home/McMyAdmin/McMyAdmin.conf <<EOF
#McMyAdmin Configuration File
################################
#DO NOT EDIT WHILE MCMYADMIN IS RUNNING
################################

################################
# Security
################################
# Security.AuthMethod - Enterprise only - setting to 'ldap' allows authentication via an LDAP server. 'hybrid' tries LDAP first, then internal.
Security.AuthMethod=internal
Security.AllowExec=False
Security.BannedPlugins=
# Security.LDAPDomain - Enterprise only - domain to use for LDAP authentication
Security.LDAPDomain=localdomain
Security.ExecPath=Exec
Security.ClusterOrigin=*
# Security.MinimumPasswordGrade - The higher this value (Max 7) the higher the requirements for a password to be considered valid
Security.MinimumPasswordGrade=1
Security.AllowConcurrentSessions=False
# Security.DisableFileTransferRestrictions - If true, restrictions on file transfers (extensions, content) are lifted. Use at your own risk.
Security.DisableFileTransferRestrictions=False
Security.RequirePasswordChange=False

################################
# Webserver
################################
Webserver.Port=$MCMA_PORT
Webserver.IPBinding=+
# Webserver.MaxQueueLength - The number of requests to permit the webserver to handle at any given time
Webserver.MaxQueueLength=8
Webserver.useHTTPS=False
Webserver.CertificatePath=
Webserver.CertificatePassword=

################################
# Java
################################
Java.Path=detect
Java.Memory=$JAVA_MEMORY
# Java.VM - Changing to 'server' permits use of the server JVM which improves performance, but is not installed by default (JDK is required)
Java.VM=client
Java.GC=default
Java.useIKVM=False
Java.IKVMpath=
# Java.CustomOpts - Extra arguments to pass to Java when starting the Minecraft server.
Java.CustomOpts=

################################
# Monitoring
################################
# Monitoring.UseMulticoreCPUCalc - When true, MCMA takes into account the number of CPU cores when calculating total CPU usage. If false, it calculates assuming 1 core
Monitoring.UseMulticoreCPUCalc=True
Monitoring.SevereRestart=False
# Monitoring.TitleSuffix - Suffix to append to the terminal title
Monitoring.TitleSuffix=
Monitoring.LogLevel=2
Monitoring.EnableConsoleColoring=True

################################
# Notices
################################
Notices.ShowPermissionsError=True
Notices.AnnouncePlayers=True
Notices.SaveWarning=True
Notices.AnnounceGroupChange=True
Notices.WhitelistMessage=You are not on the whitelist.

################################
# McMyAdmin
################################
McMyAdmin.ScheduleOffset=0
McMyAdmin.BackupsPath=Backups
McMyAdmin.BannerTemplate=BannerTemplate
# McMyAdmin.LicenceKey - Empty when using new licence system. A modern licence entered here will be activated as normal.
McMyAdmin.LicenceKey=
McMyAdmin.FirstStart=False
McMyAdmin.LoadExtensions=
# McMyAdmin.ClusterMember - Not currently in use
McMyAdmin.ClusterMember=False
# McMyAdmin.ClusterGroup - Not currently in use
McMyAdmin.ClusterGroup=Default
McMyAdmin.ShutdownProperly=True
# McMyAdmin.BackupConfigExtensions - Comma-separated list of extensions to include for backup when including plugin configuration. Set this to '*' to include all extensions except .jar
McMyAdmin.BackupConfigExtensions=yml,txt,cfg,conf,yaml,json,ini
McMyAdmin.BackupOverflowMode=DeleteOldest
# McMyAdmin.ThrottleBackups - Whether or not to throttle backups to limit CPU usage
McMyAdmin.ThrottleBackups=False
# McMyAdmin.BackupThrottleDelay - Number of milliseconds to wait between adding each file when throttling backups
McMyAdmin.BackupThrottleDelay=10
# McMyAdmin.NoBackupCompression - Disables compression for backups, producing an archive only
McMyAdmin.NoBackupCompression=False
McMyAdmin.IncludePermissionsInScheduledBackup=False
McMyAdmin.IncludePluginsInScheduledBackup=False
McMyAdmin.IncludePluginConfigInScheduledBackup=False
# McMyAdmin.Instance - Used for multiple instance management. This number is added to the webserver port (so 8080 with instance 4 would have run on port 8084)
McMyAdmin.Instance=0

################################
# Provider
################################
Provider.Name=Provider name not set
Provider.URL=http://www.example.com/
Provider.SupportURL=http://www.example.com/support

################################
# Server
################################
Server.Name=$MCMA_SERVER_NAME
Server.Address=localhost:$MCMA_PORT
Server.UseBukkitBeta=False
Server.ServerType=FeedTheBeast
# Server.LockToVanilla - Enterprise Only - Lock the server to only run Vanilla servers
Server.LockToVanilla=False
# Server.ApprovedVanillaHashes - Enterprise Only - Comma-separated list of approved hashes for minecraft_server.jar when LockToVanilla is set (ignored if empty)
Server.ApprovedVanillaHashes=
Server.MinecraftPath=./Minecraft/
# Server.MinecraftRAMDiskStore - Not currently in use
Server.MinecraftRAMDiskStore=./RDSTORE/
# Server.UseRAMDisk - Not currently in use
Server.UseRAMDisk=False
# Server.ForceSetting - Enterprise only - semicolon delimited list of server.properties key:value pairs to force upon the Minecraft server.
Server.ForceSetting=
Server.StatusImage=False
Server.SaveOnStop=True
Server.SleepDelayMinutes=5
Server.SleepWhenEmpty=False
Server.SleepOnFirstStart=False
# Server.ForceSleepMode - Enterprise only - force server sleeping despite SleepWhenEmpty setting
Server.ForceSleepMode=False
Server.ServerSleepMessage=Server dormido. Reingresá en 15 segundos ...
# Server.UseUTF8Mode - UTF8 mode allows the use of accented characters for the in-game chat. This may require that existing ANSI encoded configuration files are converted to UTF8
Server.UseUTF8Mode=True
# Server.DelayRestart - Number of milliseconds to delay startup when performing a restart.
Server.DelayRestart=0

################################
# Widget
################################
Widget.Background=#5F8EAE
Widget.TextColor=white
Widget.FontFamily=Verdana, sans-serif

################################
# Export
################################
Export.GMType=None
Export.mchatFormat=<+prefix+dname+suffix&f> +message

################################
# Limits
################################
Limits.MaxPlayers=10
Limits.MaxBackups=7
Limits.MaxBackupsTotalSizeMB=4096
Limits.MaxFailures=5
# Limits.MinMinutesSinceLastBackup - Enterprise only - the number of minutes that must have passed between backups being created
Limits.MinMinutesSinceLastBackup=0
# Limits.MaxDirRecursionDepth - Maxumum number of directories deep to scan for worlds
Limits.MaxDirRecursionDepth=4
# Limits.SlotEnforcement - Enterprise only - Enforce slot limit by monitoring the number of active connections to the Minecraft server. Triggers a restart if the limit remains exceeded.
Limits.SlotEnforcement=False
# Limits.SlotOverage - Enterprise only - Maximum overage on slot limit.
Limits.SlotOverage=1
# Limits.SlotOvertime - Enterprise only - Number of minutes for slot overage before triggering a restart.
Limits.SlotOvertime=5

################################
# Login
################################
Login.Username=vic
Login.PasswordHash=rK1cGjXZcMpTQe7DySA/k9OsBqGSXyj9vz+hWcSqrf4=
Login.PasswordSalt=0fBvT0XL7ejigbO/6Rc4

################################
# Game
################################
Game.MOTD=%p!\n$MCMA_MOTD
Game.Public=False
Game.Whitelist=None
Game.WhitelistGroup=Everyone

EOF

mkdir -p /home/McMyAdmin/Minecraft/local/ftbutilities; touch /home/McMyAdmin/Minecraft/local/ftbutilities/config.cfg
sed '/^[[:blank:]]*#/d;/^\s*$/d' > /home/McMyAdmin/Minecraft/local/ftbutilities/config.cfg <<EOF
# Configuration file

config {

    auto_shutdown {
        B:enabled=false

        # Server will automatically shut down after X hours
        # Time Format: HH:MM. If the system time matches a value, server will shut down
        # It will look for closest value available that is not equal to current time
        S:times <
            04:00
            16:00
         >
    }

    server_info {
        B:difficulty=true
        B:motd=true
    }

    chat {
        # Min: 0
        # Max: 10000000
        I:admin_history_limit=10000

        # Min: 0
        # Max: 10000000
        I:general_history_limit=10000

        # Min: 0
        # Max: 10000000
        I:team_history_limit=1000
    }

    backups {
        # Timer in hours
        # 1.0 - backups every hour
        # 6.0 - backups every 6 hours
        # 0.5 - backups every 30 minutes
        # Min: 0.05
        # Max: 600.0
        D:backup_timer=2.0

        # The number of backup files to keep
        # More backups = more space used
        # 0 - Infinite
        # Min: 0
        # Max: 32000
        I:backups_to_keep=12

        # 0 - Disabled (output = folders)
        # 1 - Best speed
        # 9 - Smallest file size
        # Min: 0
        # Max: 9
        I:compression_level=1

        # Prints (current size | total size) when backup is done
        B:display_file_size=true
        B:enabled=$FTBU_BACKUPS_ENABLED

        # Absolute path to backups folder
        S:folder=
        B:silent=false

        # Run backup in a separated Thread (recommended)
        B:use_separate_thread=true
    }

    commands {
        B:back=true
        B:chunks=true
        B:fly=true
        B:heal=true
        B:home=true
        B:inv=true
        B:kickme=true
        B:killall=true
        B:leaderboard=true
        B:nbtedit=true
        B:ranks=true
        B:set_hour=true
        B:spawn=true
        B:tpl=true
        B:trash_can=true
        B:view_crash=true
        B:warp=true
    }

    login {
        # Set to false to disable event badges, e.g. Halloween
        B:enable_event_badges=true

        # Set to false to disable global badges completely, only server-wide badges will be available
        B:enable_global_badges=true
        B:enable_motd=false
        B:enable_starting_items=false

        # Message of the day. This will be displayed when player joins the server
        S:motd <
            "Hello player!"
         >

        # Items to give player when he first joins the server
        # Format: '{id:"ID",Count:X,Damage:X,tag:{}}'
        S:starting_items <
            {id:"minecraft:stone_sword",Count:1,Damage:1,tag:{display:{Name:"Epic Stone Sword"}}}
         >
    }

    ranks {
        B:enabled=true
        B:override_chat=true
        B:override_commands=true
    }

    world {
        # Dimensions where chunk claiming isn't allowed
        I:blocked_claiming_dimensions <
         >
        B:chunk_claiming=true
        B:chunk_loading=true

        # If set to DEFAULT, then teams can decide their Explosion setting
        # Valid values:
        # TRUE
        # FALSE
        # DEFAULT
        S:enable_explosions=DEFAULT

        # If set to DEFAULT, then players can decide their PVP status
        # Valid values:
        # TRUE
        # FALSE
        # DEFAULT
        S:enable_pvp=DEFAULT

        # Print a message in console every time a chunk is forced or unforced. Recommended to be off, because spam
        B:log_chunkloading=false

        # If set to true, explosions and hostile mobs in spawn area will be disabled, players won't be able to attack each other in spawn area
        B:safe_spawn=false

        # Enable spawn area in singleplayer
        B:spawn_area_in_sp=false
    }

}

EOF

cd /home/McMyAdmin; ./MCMA2_Linux_x86_64
