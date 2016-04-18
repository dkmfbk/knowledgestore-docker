import org.openrdf.model.*;
import org.openrdf.model.impl.*;
import java.util.regex.*;

def init(args) {
  type = <http://www.w3.org/TR/owl-time#DateTimeDescription>;
  pattern = Pattern.compile("(\\d{4})?(\\d{2})?(\\d{2})?\$");
}

if (o instanceof URI && s instanceof URI && o.equals(type)) {
  string = s.stringValue();
  matcher = pattern.matcher(string);
  if (matcher.find()) {
    year = matcher.group(1);
    month = matcher.group(2);
    day = matcher.group(3);
    builder = new StringBuilder();
    builder.append(year);
    if (month != null) {
      builder.append("-").append(month);
      if (day != null) {
        builder.append("-").append(day);
      }
    }
    emit(s, rdfs:label, new LiteralImpl(builder.toString()), c);
  }
}

