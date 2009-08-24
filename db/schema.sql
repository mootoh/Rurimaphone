CREATE TABLE method (
  names      CHAR(64) NOT NULL,
  class      CHAR(64) NOT NULL,
  kind       CHAR(64),
  visibility CHAR(64),
  body       TEXT
);

CREATE TABLE class (
  name        CHAR(64) NOT NULL PRIMARY KEY,
  type        CHAR(64),
  superclass  CHAR(64),
  included    CHAR(64),
  extended    CHAR(64),
  library     CHAR(64) NOT NULL,
  body        TEXT
);
