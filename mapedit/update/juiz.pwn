#define INVALID_PLAYER_3DTEXT_ID               (PlayerText3D:0xFFFF)
new PlayerText3D:objectindex3d[MAX_OBJECTS] = {INVALID_PLAYER_3DTEXT_ID, ...};
new hidetext3d;
new timertext3d;

forward UpdateText3D(playerid);
public UpdateText3D(playerid)
{   
    static Float:x, Float:y, Float:z;
    for(new i = 0; i < MAX_OBJECTS; ++i)
    {
        if(hidetext3d == 0)
        {
            if(IsValidObject(i))
            {
                if(objectindex3d[i] == INVALID_PLAYER_3DTEXT_ID)
                {
                    GetObjectPos(i, x, y, z); 
                    static string[64];
                    format(string, sizeof(string), "Idx: {FF1C21}%d{D8CD43} - {FF1C21}%d", i, GetObjectModel(i));
                    //DeletePlayer3DTextLabel(objectindex3d[i]);

                    objectindex3d[i] = CreatePlayer3DTextLabel(playerid, string, 0xD8CD43FF, x, y, z, 900.0);
                }
            }
            else
            {
                if(!IsValidObject(i))
                {
                    if(objectindex3d[i] != INVALID_PLAYER_3DTEXT_ID)
                    {
                        DeletePlayer3DTextLabel(playerid, objectindex3d[i]);
                        objectindex3d[i] = INVALID_PLAYER_3DTEXT_ID;
                    }
                }
            }
        }
        else
        {
            if(objectindex3d[i] != INVALID_PLAYER_3DTEXT_ID)
            {
                DeletePlayer3DTextLabel(playerid, objectindex3d[i]);
                objectindex3d[i] = INVALID_PLAYER_3DTEXT_ID;
            }
        }
    }
    return 1;
}

CMD:cp(playerid)
{
    new Float:x, Float:y, Float:z;

    GetPlayerPos(playerid, x, y, z);
    SetPlayerCheckpoint(playerid, x, y, z + 0.5, 1.5);
    return 1;
}

CMD:cp1(playerid)
{
    new Float:x, Float:y, Float:z;

    GetPlayerPos(playerid, x, y, z);
    SetPlayerCheckpoint(playerid, x, y, z + 1.5, 1.5);
    return 1;
}

CMD:cp2(playerid)
{
    new Float:x, Float:y, Float:z;

    GetPlayerPos(playerid, x, y, z);
    SetPlayerCheckpoint(playerid, x, y, z + 3.5, 1.5);
    return 1;
}

CMD:cp3(playerid)
{
	SetPlayerCheckpoint(playerid, 1757.7467,-1236.3423,2353.2, 1.5);
	return 1;
}

CMD:edit(playerid, params[])
{
    new objectidx;
    if(sscanf(params, "d", objectidx))
    {
        SendClientMessage(playerid, 0xBFBFBFAA, "Use: /edit [idx]");
        return 1;
    }

    if(!IsValidObject(objectidx))
    {
        SendClientMessage(playerid, 0xD94246FF, "This object dont exist!");
        return 1;
    }

    g_PlayerData[playerid][PLAYER_DATA_EDIT_ID] = objectidx;
    g_PlayerData[playerid][PLAYER_DATA_EDIT_IDTYPE] = ID_TYPE_OBJECT;
    ShowObjectDialog(playerid, DIALOGID_OBJECT_MAIN);

    new string[64];
    format(string, sizeof(string), "You edit object idx: {FF1C21}%d{D8CD43} model {FF1C21}%d", objectidx, GetObjectModel(objectidx));
    SendClientMessage(playerid, 0xD8CD43FF, string);
    return 1;
}

CMD:show(playerid)
{
    if(!hidetext3d)
    {
        hidetext3d = 1;
        SendClientMessage(playerid, 0xEB8383FF, "You show text3d!");
    }
    else
    {
        hidetext3d = 0;
        SendClientMessage(playerid, 0x5FBC8FFF, "You hide text3d!");
    }

    for(new i = 0; i < MAX_OBJECTS; ++i)
    {
        if(hidetext3d)
        {
            DeletePlayer3DTextLabel(playerid, objectindex3d[i]);
            objectindex3d[i] = INVALID_PLAYER_3DTEXT_ID; 
        }
        else
        {
            static Float:x, Float:y, Float:z;
            if(IsValidObject(i))
            {
                if(objectindex3d[i] == INVALID_PLAYER_3DTEXT_ID)
                {
                    GetObjectPos(i, x, y, z); 
                    static string[64];
                    format(string, sizeof(string), "Idx: {FF1C21}%d{D8CD43} - {FF1C21}%d", i, GetObjectModel(i));

                    objectindex3d[i] = CreatePlayer3DTextLabel(playerid, string, 0xD8CD43FF, x, y, z, 50.0);
                }
            }
        }
    }
    return 1;
}