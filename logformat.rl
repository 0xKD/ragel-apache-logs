%%{
	machine logformat;
	action saveptr { saveptr(); }

	ipaddr  = [0-9\.]+ > saveptr % { test(); };
	blank   = '-';
	user    = alpha+;
	date    = [^\]]+;
	request = [^"]+;
	status  = ([12345]digit{2});
	size    = (digit+ | '-');
	referer = [^"]*;
	agent   = [^"]*;

	line = (
		ipaddr          space
		blank           space
		blank           space
		'[' date ']'    space
		'"' request '"' space
		status          space
		size            space
		'"' referer '"' space
		'"' agent '"'
	);

}%%
