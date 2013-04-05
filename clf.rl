%%{

  machine clf;

  # Registers the mark action, but delegates its implementation to the host 
  # language
  action mark { mark(); }

  # Define the various components of a log entry
  #
  # > and % denote entering and leaving actions respectively, so this machine
  #   will mark and emit each of the following token types as it sees them
  host    = [0-9\.]+       >mark %{ emit("host");    };
  user    = alpha+         >mark %{ emit("user");    };
  date    = [^\]]+         >mark %{ emit("date");    };
  request = [^"]+          >mark %{ emit("request"); };
  status  = digit+         >mark %{ emit("status");  };
  size    = (digit+ | '-') >mark %{ emit("size");    };
  url     = [^"]*          >mark %{ emit("url");     };
  agent   = [^"]*          >mark %{ emit("agent");   };

  # Assemble the components to define a single line
  line = (
    host            space
    '-'             space
    '-'             space
    '[' date ']'    space
    '"' request '"' space
    status          space
    size            space
    '"' url '"'     space
    '"' agent '"'   '\n'
  );

}%%