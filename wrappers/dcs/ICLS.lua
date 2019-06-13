-- ICLS KOBULETI Example add to end of Mods/terrains/Caucasus/Beacons.lua

table.insert(beacons,
	{
		display_name = _('');
		beaconId = 'airfield24_5';
		type = BEACON_TYPE_ICLS_LOCALIZER;
		callsign = 'IKB';
		frequency = 111500000.000000;
		channel = 10;
		position = { -317495.750000, 18.017043, 636918.250000 };
		direction = -109.999979;
		positionGeo = { latitude = 41.932878, longitude = 41.879171 };
		sceneObjects = {'t:177112081'};
		chartOffsetX = 2550.000000;
	}
);

table.insert(beacons,
	{
		display_name = _('');
		beaconId = 'airfield24_6';
		type = BEACON_TYPE_ICLS_GLIDESLOPE;
		callsign = '';
		frequency = 111500000.000000;
		channel = 10;
		position = { -318329.625000, 18.010016, 634820.812500 };
		direction = -109.999979;
		positionGeo = { latitude = 41.927403, longitude = 41.853140 };
		sceneObjects = {'t:335085572'};
		chartOffsetX = 120.000000;
	}
);
