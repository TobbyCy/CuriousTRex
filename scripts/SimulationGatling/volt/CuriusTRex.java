package volt;

import java.time.Duration;
import java.util.*;

import io.gatling.javaapi.core.*;
import io.gatling.javaapi.http.*;
import io.gatling.javaapi.jdbc.*;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;
import static io.gatling.javaapi.jdbc.JdbcDsl.*;

public class CuriusTRex extends Simulation {

  private HttpProtocolBuilder httpProtocol = http
    .baseUrl("http://volt")
    .inferHtmlResources()
    .acceptHeader("image/avif,image/webp,*/*")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3")
    .userAgentHeader("Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/114.0");
  
  private Map<CharSequence, String> headers_0 = Map.ofEntries(
    Map.entry("Accept", "text/css,*/*;q=0.1"),
    Map.entry("If-Modified-Since", "Thu, 17 Aug 2023 08:18:41 GMT"),
    Map.entry("If-None-Match", "\"dc3-6031a0f5b4a47-gzip\"")
  );
  
  private Map<CharSequence, String> headers_1 = Map.ofEntries(
    Map.entry("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8"),
    Map.entry("Upgrade-Insecure-Requests", "1")
  );
  
  private Map<CharSequence, String> headers_4 = Map.ofEntries(
    Map.entry("If-Modified-Since", "Thu, 17 Aug 2023 07:26:33 GMT"),
    Map.entry("If-None-Match", "\"164ac-6031954e8df3b\"")
  );
  
  private Map<CharSequence, String> headers_6 = Map.ofEntries(
    Map.entry("If-Modified-Since", "Thu, 17 Aug 2023 07:26:33 GMT"),
    Map.entry("If-None-Match", "\"14c4c-6031954e8cf9b\"")
  );
  
  private Map<CharSequence, String> headers_7 = Map.ofEntries(
    Map.entry("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8"),
    Map.entry("If-Modified-Since", "Thu, 17 Aug 2023 08:08:51 GMT"),
    Map.entry("If-None-Match", "\"2129-60319ec28bede-gzip\""),
    Map.entry("Upgrade-Insecure-Requests", "1")
  );


  private ScenarioBuilder scn = scenario("CuriusTRex")
    .exec(
      http("request_0")
        .get("/styles.css")
        .headers(headers_0)
    )
    .pause(15)
    // Start
    .exec(
      http("request_1")
        .get("/contact.html")
        .headers(headers_1)
    )
    .pause(9)
    .exec(
      http("request_2")
        .get("/about.html")
        .headers(headers_1)
        .resources(
          http("request_3")
            .get("/capture/Home.jpg"),
          http("request_4")
            .get("/capture/Test_Complet.jpg")
            .headers(headers_4),
          http("request_5")
            .get("/capture/Donn%C3%A9es.jpg"),
          http("request_6")
            .get("/capture/Test.jpg")
            .headers(headers_6)
        )
    )
    .pause(11)
    .exec(
      http("request_7")
        .get("/about.html")
        .headers(headers_7)
    );

  {
	  setUp(scn.injectOpen(rampUsers(10000).during(90))).protocols(httpProtocol);
  }
}
