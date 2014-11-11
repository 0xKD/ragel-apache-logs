%%{
	machine logformat;
	action saveptr { saveptr(); }

	ipaddr  = [0-9\.]+ > saveptr % { nullify();save_ip(myLog); };
	blank   = '-';
	user    = alpha+;
	date    = [^\]]+ > saveptr % { nullify();save_date(myLog); };
	request = [^"]+ > saveptr % { nullify();save_request(myLog); };
	status  = ([12345]digit{2}) > saveptr % { nullify();save_status(myLog); };
	size    = (digit+ | '-') > saveptr % { nullify();save_size(myLog); };
	referer = [^"]* > saveptr % { nullify();save_referer(myLog); };
	agent   = [^"]* > saveptr % { nullify();save_useragent(myLog); };


	line = (
		ipaddr          space
		blank           space
		blank           space
		'[' date ']'    space
		'"' request '"' space
		status          space
		size            space
		'"' referer '"' space
		'"' agent '"'   '\n'
	);

}%%
