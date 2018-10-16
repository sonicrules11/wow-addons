-- Spanish localization file for esES and esMX.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "esES") or AceLocale:NewLocale("ElvUI", "esMX")
if not L then return end

--*_ADDON locales
L["INCOMPATIBLE_ADDON"] = "The addon %s is not compatible with ElvUI's %s module. Please select either the addon or the ElvUI module to disable."

--*_MSG locales
L["LOGIN_MSG"] = "Welcome to %sElvUI|r version %s%s|r, type /ec to access the in-game configuration menu. If you are in need of technical support you can visit us at https://github.com/ElvUI-Cataclysm or join our Discord: https://discord.gg/Uatdmm7"

--ActionBars
L["Binding"] = "Controles"
L["Key"] = "Tecla"
L["KEY_ALT"] = "A"
L["KEY_CTRL"] = "C"
L["KEY_DELETE"] = "Del"
L["KEY_HOME"] = "Hm"
L["KEY_INSERT"] = "Ins"
L["KEY_MOUSEBUTTON"] = "M"
L["KEY_MOUSEWHEELDOWN"] = "MwD"
L["KEY_MOUSEWHEELUP"] = "MwU"
L["KEY_NUMPAD"] = "N"
L["KEY_PAGEDOWN"] = "PD"
L["KEY_PAGEUP"] = "PU"
L["KEY_SHIFT"] = "S"
L["KEY_SPACE"] = "SpB"
L["No bindings set."] = "No hay teclas establecidas."
L["Remove Bar %d Action Page"] = "Quitar Barra %d de la paginación"
L["Trigger"] = "Disparador"

--Bags
L["Bank"] = "Banco"
L["Hold Control + Right Click:"] = "Mantén Control y Haz Clic Derecho:"
L["Hold Shift + Drag:"] = "Mantén Shift y Arrastra:"
L["Purchase Bags"] = "Comprar Bolsas"
L["Reset Position"] = "Reestablecer Posición"
L["Sort Bags"] = "Ordenar Bolsas"
L["Temporary Move"] = "Movimiento Temporal"
L["Toggle Bags"] = "Mostrar/Ocultar Bolsas"
L["Vendor / Delete Grays"] = true

--Chat
L["AFK"] = "Ausente"
L["BG"] = true
L["BGL"] = true
L["DND"] = "Oc"
L["G"] = "H"
L["Invalid Target"] = "Objetivo Inválido"
L["O"] = "O"
L["P"] = "G"
L["PL"] = "LG"
L["R"] = "B"
L["RL"] = "LB"
L["RW"] = "AB"
L["says"] = "dice"
L["whispers"] = "susurra"
L["yells"] = "grita"

--DataTexts
L["(Hold Shift) Memory Usage"] = "(Mantén Shift) Uso de Memoria"
L["Avoidance Breakdown"] = "Desglose de Evasión"
L["Bandwidth"] = "Ancho de Banda"
L["Character: "] = "Personaje: "
L["Combat Time"] = true
L["Coords"] = true
L["copperabbrev"] = "|cffeda55fc|r"
L["Deficit:"] = "Déficit:"
L["Download"] = "Descarga"
L["DPS"] = "DPS"
L["Earned:"] = "Ganada:"
L["Friends List"] = "Lista de Amigos"
L["Gold"] = "Oro"
L["goldabbrev"] = "|cffffd700g|r"
L["Hit"] = "Golpe"
L["Hold Shift + Right Click:"] = "Mantén Shift + Botón Derecho:"
L["Home Latency:"] = "Latencia Local:"
L["Home Protocol:"] = true
L["HP"] = "Salud"
L["HPS"] = "VPS"
L["lvl"] = "Niv"
L["Mitigation By Level: "] = "Mitigación Por Nivel: "
L["Mov. Speed:"] = STAT_MOVEMENT_SPEED
L["No Guild"] = "Sin Hermandad"
L["Profit:"] = "Ganancia:"
L["Reload UI"] = true
L["Reset Counters: Hold Control + Right Click"] = true
L["Reset Data: Hold Shift + Right Click"] = "Restablecer Datos: Mantén Shift + Clic Derecho"
L["Saved Dungeon(s)"] = true
L["Saved Raid(s)"] = "Banda(s) Guardada(s)"
L["Server: "] = "Servidor: "
L["Session:"] = "Sesión:"
L["silverabbrev"] = "|cffc7c7cfs|r"
L["SP"] = "PH"
L["Spell/Heal Power"] = true
L["Spec"] = true
L["Spent:"] = "Gastada:"
L["Stats For:"] = "Estadísticas para:"
L["System"] = true
L["Talent Specialization"] = true
L["Total CPU:"] = "CPU Total:"
L["Total Memory:"] = "Memoria Total:"
L["Total: "] = "Total: "
L["Unhittable:"] = "Imbatible:"
L["Vengeance"] = true
L["World Protocol:"] = true
L["|cffFFFFFFLeft Click:|r Change Talent Specialization"] = "|cffFFFFFFClick Izquierdo:|r Cambiar Especialización de Talentos"
L["|cffFFFFFFShift + Left Click:|r Show Talent Specialization UI"] = "|cffFFFFFFClick Derecho:|r Mostrar Interfaz de Especialización de Talentos"

--DebugTools
L["%s: %s tried to call the protected function '%s'."] = "%s: %s intentó llamar a la función protegida '%s'."
L["No locals to dump"] = "No hay locales para volcar"

--Distributor
L["%s is attempting to share his filters with you. Would you like to accept the request?"] = "%s quiere compartir sus filtros contigo. ¿Aceptas la petición?"
L["%s is attempting to share the profile %s with you. Would you like to accept the request?"] = "%s quiere compartir el perfil %s contigo. ¿Aceptas la petición?"
L["Data From: %s"] = "Datos De: %s"
L["Filter download complete from %s, would you like to apply changes now?"] = "Se completó la descarga de los filtros de %s. ¿Quieres aplicar los cambios ahora?"
L["Lord! It's a miracle! The download up and vanished like a fart in the wind! Try Again!"] = "¡Milagro! ¡La descarga se desvaneció como pedo! Intenta de nuevo"
L["Profile download complete from %s, but the profile %s already exists. Change the name or else it will overwrite the existing profile."] = "Descarga de perfil de %s completa, pero el perfil %s ya existe. Cámbiale el nombre o se reemplazará el perfil existente."
L["Profile download complete from %s, would you like to load the profile %s now?"] = "Descarga de perfil de %s completa ¿Quieres cargar el perfil %s ahora?"
L["Profile request sent. Waiting for response from player."] = "Petición de perfil enviada. Esperando respuesta del jugador."
L["Request was denied by user."] = "Petición denegada por el jugador."
L["Your profile was successfully recieved by the player."] = "Tu perfil ha sido recibido exitosamente por el jugador."

--Install
L["Aura Bars & Icons"] = "Barras de Auras e Iconos"
L["Auras Set"] = "Auras Configuradas"
L["Auras"] = true
L["Caster DPS"] = "DPS Hechizos"
L["Chat Set"] = "Chat Configurado"
L["Chat"] = "Chat"
L["Choose a theme layout you wish to use for your initial setup."] = "Elige un tema de distribución para usar en tu configuración inicial."
L["Classic"] = "Clásico"
L["Click the button below to resize your chat frames, unitframes, and reposition your actionbars."] = "Haz clic en el botón de abajo para cambiar el tamaño de los marcos de chat y de unidad, y reubicar tus barras de acción."
L["Config Mode:"] = "Modo de Configuración"
L["CVars Set"] = "CVars Configuradas"
L["CVars"] = "CVars"
L["Dark"] = "Oscuro"
L["Disable"] = "Desactivar"
L["ElvUI Installation"] = "Instalación de ElvUI"
L["Finished"] = "Terminado"
L["Grid Size:"] = "Tamaño de la Rejilla:"
L["Healer"] = "Sanador"
L["High Resolution"] = "Alta Resolución"
L["high"] = "alta"
L["Icons Only"] = "Sólo Iconos"
L["If you have an icon or aurabar that you don't want to display simply hold down shift and right click the icon for it to disapear."] = "Si tienes un icono o una barra de aura que no quieres ver simplemente mantén pulsado la tecla Shift y haz clic con el botón izquierdo del ratón en el icono para que desaparezca."
L["Importance: |cff07D400High|r"] = "Importancia: |cff07D400Alta|r"
L["Importance: |cffD3CF00Medium|r"] = "Importancia: |cffD3CF00Media|r"
L["Importance: |cffFF0000Low|r"] = "Importancia: |cffFF0000Baja|r"
L["Installation Complete"] = "Instalación Completa"
L["Layout Set"] = "Distribución Establecida"
L["Layout"] = "Distribución"
L["Lock"] = "Bloquear"
L["Low Resolution"] = "Baja Resolución"
L["low"] = "baja"
L["Nudge"] = "Ajuste Fino"
L["Physical DPS"] = "DPS Físico"
L["Please click the button below so you can setup variables and ReloadUI."] = "Haz clic en el botón de abajo para configurar variables y recargar la interfaz."
L["Please click the button below to setup your CVars."] = "Haz clic en el botón de abajo para configurar las CVars"
L["Please press the continue button to go onto the next step."] = "Presiona el botón de continuar para ir al siguiente paso"
L["Resolution Style Set"] = "Estilo de Resolución Establecido"
L["Resolution"] = "Resolución"
L["Select the type of aura system you want to use with ElvUI's unitframes. Set to Aura Bar & Icons to use both aura bars and icons, set to icons only to only see icons."] = "Selecciona el tipo de sistema de de auras que deseas utilizar con los marcos de unidad de ElvUI. Establécelo a Barras de Auras e Iconos para usar a la vez la barra de auras y los iconos, establécelo en Sólo Iconos para ver solo los iconos."
L["Setup Chat"] = "Configurar Chat"
L["Setup CVars"] = "Configurar CVars"
L["Skip Process"] = "Saltar Proceso"
L["Sticky Frames"] = "Marcos Adhesivos"
L["Tank"] = "Tanque"
L["The chat windows function the same as Blizzard standard chat windows, you can right click the tabs and drag them around, rename, etc. Please click the button below to setup your chat windows."] = "Las ventanas de chat funcionan igual que sus contrapartes estándar de Blizzard. Puedes hacer clic derecho en las pestañas y arrastrarlas, cambiarles el nombre, etc. Haz clic en el botón de abajo para configurar las ventanas de chat."
L["The in-game configuration menu can be accessed by typing the /ec command or by clicking the 'C' button on the minimap. Press the button below if you wish to skip the installation process."] = "El menú de configuración puede ser accedido mediante el comando /ec o haciendo clic en el botón 'C' del minimapa. Presiona el botón de abajo si deseas saltarte la instalación."
L["Theme Set"] = "Establecer Tema"
L["Theme Setup"] = "Configurar Tema"
L["This install process will help you learn some of the features in ElvUI has to offer and also prepare your user interface for usage."] = "El proceso de instalación te ayudará a aprender algunas de las características de ElvUI y preparará la interfaz para su uso."
L["This is completely optional."] = "Esto es completamente opcional."
L["This part of the installation process sets up your chat windows names, positions and colors."] = "Esta parte de la instalación configura los nombres, posiciones y colores de las ventanas de chat."
L["This part of the installation process sets up your World of Warcraft default options it is recommended you should do this step for everything to behave properly."] = "Esta parte de la instalación configura las opciones predeterminadas de World of Warcraft. Se recomienda hacer este paso para que todo funcione apropiadamente."
L["This resolution doesn't require that you change settings for the UI to fit on your screen."] = "Esta resolución no necesita que cambies los ajustes para que quepa la interfaz en tu pantalla."
L["This resolution requires that you change some settings to get everything to fit on your screen."] = "Esta resolución requiere que cambies algunos ajustes para que todo quepa en tu pantalla."
L["This will change the layout of your unitframes and actionbars."] = "Ésto cambiará el diseño de los marcos de unidades y barras de acción."
L["Welcome to ElvUI version %s!"] = "Bienvenido(a) a ElvUI versión %s!"
L["You are now finished with the installation process. If you are in need of technical support please visit us at https://github.com/ElvUI-Cataclysm"] = "Ya has terminado con el proceso de instalación. Si necesitas ayuda o soporte técnico por favor visítanos en https://github.com/ElvUI-Cataclysm"
L["You can always change fonts and colors of any element of ElvUI from the in-game configuration."] = "Siempre puedes cambiar las fuentes y colores de cualquier elemento de ElvUI desde la configuración."
L["You can now choose what layout you wish to use based on your combat role."] = "Ahora puedes elegir qué distribución quieres basándote en tu rol de combate."
L["You may need to further alter these settings depending how low you resolution is."] = "Puede que necesites cambiar estos ajutes dependiendo de qué tan baja sea tu resolución."
L["Your current resolution is %s, this is considered a %s resolution."] = "Tu resolución actual es %s, esto se considera una resolución %s."

--Misc
L["ABOVE_THREAT_FORMAT"] = "%s: %.0f%% [%.0f%% above |cff%02x%02x%02x%s|r]"
L["Average Group iLvl:"] = true
L["Bars"] = "Barras"
L["Calendar"] = "Calendario"
L["Can't Roll"] = "No puede tirar dados"
L["Disband Group"] = "Disolver Grupo"
L["Empty Slot"] = true
L["Enable"] = "Habilitar"
L["Experience"] = "Experiencia"
L["Farm Mode"] = true
L["Fishy Loot"] = "Botín Sospechoso"
L["iLvl"] = true --Column header in raidbrowser
L["Left Click:"] = "Click Izquierdo"
L["Raid Menu"] = "Menú de Banda"
L["Remaining:"] = "Restante"
L["Rested:"] = "Descansado:"
L["Right Click:"] = "Click Derecho"
L["Show BG Texts"] = "Mostrar Textos de CB"
L["Talent Spec"] = true --Column header in raidbrowser
L["Toggle Chat Frame"] = "Mostrar/Ocultar Marco de Chat"
L["Toggle Configuration"] = "Mostrar/Ocultar Configuración"
L["XP:"] = "XP:"
L["You don't have permission to mark targets."] = "No tienes permiso para marcar objetivos."

--Movers
L["Alternative Power"] = "Poder Alternativo"
L["Arena Frames"] = "Marcos de Arena"
L["Bag Mover (Grow Down)"] = "Fijador de Bolsa (Crecer hacia abajo)"
L["Bag Mover (Grow Up)"] = "Fijador de Bolsa (Crecer hacia arriba)"
L["Bag Mover"] = "Fijador de Bolsa"
L["Bags"] = "Bolsas"
L["Bank Mover (Grow Down)"] = "Fijador de Banco (Crecer hacia abajo)"
L["Bank Mover (Grow Up)"] = "Fijador de Banco (Crecer hacia arriba)"
L["Bar "] = "Barra "
L["BNet Frame"] = "Marco BNet"
L["Boss Button"] = "Botón de Jefe"
L["Boss Frames"] = "Marco de Jefe"
L["Class Totems"] = true
L["Classbar"] = "Barra de Clase"
L["Error Frame"] = true
L["Experience Bar"] = "Barra de Experiencia"
L["Focus Castbar"] = "Barra de Lanzamiento del Foco"
L["Focus Frame"] = "Marco de Foco"
L["FocusTarget Frame"] = "Marco de Objetivo del Foco"
L["GM Ticket Frame"] = "Marco de Consultas para el MJ"
L["Left Chat"] = "Chat Izquierdo"
L["Loot / Alert Frames"] = "Marcos de Botín / Alerta"
L["Loot Frame"] = "Marco de Botín"
L["MA Frames"] = "Marcos de AP"
L["Micro Bar"] = "Micro Barra"
L["Minimap"] = "Minimapa"
L["MirrorTimer"] = true
L["MT Frames"] = "Marcos de TP"
L["Objective Frame"] = "Marco de Objetivo"
L["Party Frames"] = "Marco de Grupo"
L["Pet Bar"] = "Barra de Mascota"
L["Pet Castbar"] = "Barra de Lanzamiento de Mascota"
L["Pet Frame"] = "Marco de Mascota"
L["PetTarget Frame"] = "Marco de Objetivo de Mascota"
L["Player Buffs"] = "Ventajas de Jugador"
L["Player Castbar"] = "Barra de Lanzamiento del Jugador"
L["Player Debuffs"] = "Perjuicios de Jugador"
L["Player Frame"] = "Marco de Jugador"
L["PvP"] = true
L["Raid Frames"] = "Marcos de Banda"
L["Raid Pet Frames"] = "Marcos de Banda con Mascotas"
L["Raid-40 Frames"] = "Marcos de Banda de 40"
L["Reputation Bar"] = "Barra de Reputación"
L["Right Chat"] = "Chat Derecho"
L["Stance Bar"] = "Barra de Forma"
L["Target Castbar"] = "Barra de Lanzamiento del Objetivo"
L["Target Frame"] = "Marco de Objetivo"
L["TargetTarget Frame"] = "Marco de Objetivo de Objetivo"
L["TargetTargetTarget Frame"] = "Marco del Objetivo del Objetivo del Objetivo"
L["Tooltip"] = "Descripción Emergente"
L["Vehicle Seat Frame"] = "Marco del Asiento del Vehículo"
L["Weapons"] = true
L["DESC_MOVERCONFIG"] = [=[Fijadores desbloqueados. Muévelos ahora y haz click en Bloquear cuando termines.

Options:
  Shift + RightClick - Hides mover temporarily.
  Ctrl + RightClick - Resets mover position to default.
]=]

--NamePlates
L["Discipline"] = "Disciplina"
L["Holy"] = "Sagrado"
L["Restoration"] = "Restauración"

--Plugin Installer
L["ElvUI Plugin Installation"] = "Instalación del plugin de ElvUI"
L["In Progress"] = "En Progreso"
L["List of installations in queue:"] = "Lista de Instalaciones en cola:"
L["Pending"] = "Pendiente"
L["Steps"] = "Pasos"

--Prints
L[" |cff00ff00bound to |r"] = " |cff00ff00ligado(a) a |r"
L["%s frame(s) has a conflicting anchor point, please change either the buff or debuff anchor point so they are not attached to each other. Forcing the debuffs to be attached to the main unitframe until fixed."] = "El marco(s) %s tiene un punto de fijación en conflicto, por favor cambia el punto de fijación de los beneficios o los perjuicios para que no estén adjuntos entre ellos. Se forzará a los perjuicios para que se adjunten al marco de unidad principal hasta que se corrija."
L["All keybindings cleared for |cff00ff00%s|r."] = "Todos los atajos borrados para |cff00ff00%s|r."
L["Already Running.. Bailing Out!"] = "Ya está en ejecución... ¡Cancelando!"
L["Battleground datatexts temporarily hidden, to show type /bgstats or right click the 'C' icon near the minimap."] = "Textos de datos de los campos de batalla temporalmente ocultos, para mostrarlos escribe /bgstats o click derecho en 'C' donde el minimapa."
L["Battleground datatexts will now show again if you are inside a battleground."] = "Los textos de datos de los campos de batalla serán visibles de nuevo si estás en un campo de batalla."
L["Binds Discarded"] = "Teclas Descartadas"
L["Binds Saved"] = "Teclas Guardadas"
L["Confused.. Try Again!"] = "Confundido... ¡Intenta de Nuevo!"
L["No gray items to delete."] = "No hay objetos grises para eliminar."
L["The spell '%s' has been added to the Blacklist unitframe aura filter."] = "El hechizo '%s' ha sido añadido a la Lista Negra del filtro de auras del marco de unidad."
L["This setting caused a conflicting anchor point, where '%s' would be attached to itself. Please check your anchor points. Setting '%s' to be attached to '%s'."] = "Esta opción causó un punto de fijación en conflicto, donde '%s' estaría adjunto a sí mismo. Por favor comprueba tus puntos de fijación. Opción '%s' a ser fijado a '%s'"
L["Vendored gray items for: %s"] = "Objetos grises vendidos por: %s"
L["You don't have enough money to repair."] = "No tienes suficiente dinero para reparaciones."
L["You must be at a vendor."] = "Debes estar cerca de un vendedor."
L["Your items have been repaired for: "] = "Tus objetos han sido reparados por:"
L["Your items have been repaired using guild bank funds for: "] = "Tus objetos han sido reparados con fondos del banco de hermandad por:"
L["|cFFE30000Lua error recieved. You can view the error message when you exit combat."] = "|cFFE30000Error de Lua recibido. Podrás ver el error cuando salgas de combate."

--Static Popups
L["A setting you have changed will change an option for this character only. This setting that you have changed will be uneffected by changing user profiles. Changing this setting requires that you reload your User Interface."] = "La opción que has cambiado se aplicará sólo para este personaje. Esta opción no se verá alterada al cambiar el perfil de usuario. Cambiar esta opción requiere que recargues tu Interfaz de Usuario."
L["Accepting this will reset the UnitFrame settings for %s. Are you sure?"] = true
L["Accepting this will reset your Filter Priority lists for all auras on NamePlates. Are you sure?"] = true
L["Accepting this will reset your Filter Priority lists for all auras on UnitFrames. Are you sure?"] = true
L["Are you sure you want to apply this font to all ElvUI elements?"] = true
L["Are you sure you want to disband the group?"] = "¿Estás seguro que quieres deshacer el grupo?"
L["Are you sure you want to reset all the settings on this profile?"] = "¿Estás seguro que deseas restablecer todos los ajustes de este perfil?"
L["Are you sure you want to reset every mover back to it's default position?"] = "¿Estás seguro que quieres resetear cada fijador a su posición por defecto?"
L["Because of the mass confusion caused by the new aura system I've implemented a new step to the installation process. This is optional. If you like how your auras are setup go to the last step and click finished to not be prompted again. If for some reason you are prompted repeatedly please restart your game."] = "Debido a la gran confusión causada por el nuevo sistema de auras he implementado un nuevo paso en el proceso de instalación, esto es opcional. Si quieres conservar la configuración actual de tus auras ve al último paso de la instalación y haz clic en terminar para que este mensaje no vuelva a ser mostrado. Si por alguna razón se vuelve a mostrar por favor reinicia el juego."
L["Can't buy anymore slots!"] = "¡No puedes comprar más huecos!"
L["Delete gray items?"] = true
L["Disable Warning"] = "Deshabilitar Advertencia"
L["Discard"] = "Descartar"
L["Do you enjoy the new ElvUI?"] = "¿Disfrutas del nuevo ElvUI?"
L["Do you swear not to post in technical support about something not working without first disabling the addon/module combination first?"] = "¿Juras no escribir a Soporte Técnico acerca de algo que no funciona sin antes deshabilitar la combinación addon/módulo primero?"
L["ElvUI is five or more revisions out of date. You can download the newest version from https://github.com/ElvUI-Cataclysm"] = "ElvUI está cinco o mas revisiones desactualizado. Puedes descargar la versión más nueva de https://github.com/ElvUI-Cataclysm!"
L["ElvUI is out of date. You can download the newest version from https://github.com/ElvUI-Cataclysm"] = true
L["ElvUI needs to perform database optimizations please be patient."] = "ElvUI necesita realizar optimizaciones de base de datos por favor se paciente."
L["Error resetting UnitFrame."] = true
L["Hover your mouse over any actionbutton or spellbook button to bind it. Press the escape key or right click to clear the current actionbutton's keybinding."] = "Pasa tu ratón por encima de un botón de acción o de un botón del libro de hechizos para ligarlo. Pulsa escape o botón derecho para limpiar la asignación actual del botón de acción."
L["I Swear"] = "Lo Juro"
L["No, Revert Changes!"] = "¡No, Revierte los Cambios!"
L["Oh lord, you have got ElvUI and Tukui both enabled at the same time. Select an addon to disable."] = "Oh cielos, tienes ElvUI y Tukui habilitados al mismo tiempo. Elige un addon a deshabilitar"
L["One or more of the changes you have made require a ReloadUI."] = "Uno o más de los cambios que has hecho requieren una recarga de la interfaz."
L["One or more of the changes you have made will effect all characters using this addon. You will have to reload the user interface to see the changes you have made."] = "Uno o más de los cambios que has hecho afectaran a todos los personajes que usen este addon. Tendrás que recargar la intefaz de usuario para ver el cambio que has realizado."
L["Save"] = "Guardar"
L["The profile you tried to import already exists. Choose a new name or accept to overwrite the existing profile."] = "El perfil que has intentado importar ya existe. Elige un nuevo nombre o acepta sobreescribir el perfil existente."
L["Type /hellokitty to revert to old settings."] = "Escribe /hellokitty para revertir a las opciones antiguas."
L["Using the healer layout it is highly recommended you download the addon Clique if you wish to have the click-to-heal function."] = "Utilizando el diseño de sanador es altamente recomendado bajar el addon Clique si deseas tener la función de hacer clic para curar."
L["Yes, Keep Changes!"] = "¡Sí, Mantén los cambios!"
L["You have changed the Thin Border Theme option. You will have to complete the installation process to remove any graphical bugs."] = "Has cambiado la opción de Tema de Border Ligero. Tendrás que completar el proceso de instalación para quitar cualquier bug gráfico."
L["You have changed your UIScale, however you still have the AutoScale option enabled in ElvUI. Press accept if you would like to disable the Auto Scale option."] = "Has cambiado la escala de tu interfaz, sin embargo aún tienes el AutoEscalado activado en ElvUI. Pulsa aceptar si te gustaría desactivar el AutoEscalado."
L["You have imported settings which may require a UI reload to take effect. Reload now?"] = "Has importado opciones que pueden requerir una recarga de la interfaz para tomar efecto. ¿Recargar ahora?"
L["You must purchase a bank slot first!"] = "¡Debes comprar un hueco del banco primero!"

--Tooltip
L["Count"] = "Contador"
L["Item Level:"] = "Nivel de Objeto:"
L["Talent Specialization:"] = "Especialización de Talentos:"
L["Targeted By:"] = "Objetivo De:"

--Tutorials
L["A raid marker feature is available by pressing Escape -> Keybinds scroll to the bottom under ElvUI and setting a keybind for the raid marker."] = "La opción de marcador de banda está disponible pulsando Escape -> Asignar teclas -> Recorrer hacia abajo hasta ElvUI y establecer la tecla para el marcador de banda."
L["ElvUI has a dual spec feature which allows you to load different profiles based on your current spec on the fly. You can enable this from the profiles tab."] = "ElvUI tiene la posibilidad de cargar diferentes perfiles automáticamente al cambiar de especialización de talentos. Puedes activar esta función en la pestaña de perfiles."
L["For technical support visit us at https://github.com/ElvUI-Cataclysm"] = "Para soporte técnico visítanos en https://github.com/ElvUI-Cataclysm"
L["If you accidently remove a chat frame you can always go the in-game configuration menu, press install, go to the chat portion and reset them."] = "Si eliminas un marco de chat accidentalmente, siempre puedes ir a la configuración, pulsar instalar, ir a la parte del chat, y restaurarlo."
L["If you are experiencing issues with ElvUI try disabling all your addons except ElvUI, remember ElvUI is a full UI replacement addon, you cannot run two addons that do the same thing."] = "Si has experimentado errores con ElvUI prueba a desactivar todos tus addons excepto ElvUI, recuerda que ElvUI remplaza por completo la interfaz, no puede haber addons que hagan lo mismo."
L["The focus unit can be set by typing /focus when you are targeting the unit you want to focus. It is recommended you make a macro to do this."] = "El foco puede establecerse escribiendo /enfoque cuando tienes seleccionado al objetivo al cual quieres hacer foco. Es recomendable que hagas una macro para esto."
L["To move abilities on the actionbars by default hold shift + drag. You can change the modifier key from the actionbar options menu."] = "Para mover habilidades a las barras de acción mantener shift + arrastrar. Puedes cambiar la tecla de modificación desde el menú de opciones de la barra de acción."
L["To setup which channels appear in which chat frame, right click the chat tab and go to settings."] = "Para configurar que canales aparecen en el chat, haz clic con el botón derecho en la pestaña del chat y elige opciones."
L["You can access copy chat and chat menu functions by mouse over the top right corner of chat panel and left/right click on the button that will appear."] = "Puedes acceder a copiar y a las opciones del chat pasando el ratón sobre la esquina superior derecha del panel del chat y haciendo click en el botón que aparece."
L["You can see someones average item level of their gear by holding shift and mousing over them. It should appear inside the tooltip."] = "Puedes ver la media de nivel de objeto de un objetivo manteniendo pulsado shift mientras pasas el ratón por encima de él. El iNvl aparecerá en la descripción emergente."
L["You can set your keybinds quickly by typing /kb."] = "Puedes establecer tus atajos rapidamente escribiendo /kb."
L["You can toggle the microbar by using your middle mouse button on the minimap you can also accomplish this by enabling the actual microbar located in the actionbar settings."] = "Puedes acceder a la microbarra usando tu botón central del ratón sobre el minimapa. También puedes activarla desde las opciones de las barras de acción."
L["You can use the /resetui command to reset all of your movers. You can also use the command to reset a specific mover, /resetui <mover name>.\nExample: /resetui Player Frame"] = "Puedes usar el commando /resetui para restablecer todos tus fijadores. También puedes usar el comando para restablecer alguno en específico, /resetui <fijador>. PE: /resetui Player Frame"

--UnitFrames
L["Dead"] = true
L["Ghost"] = "Fantasma"
L["Offline"] = "Fuera de Línea"