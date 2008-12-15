<%@taglib 
	prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ page language="java"
	buffer="2048kb"
	import="org.codehaus.jackson.*, org.codehaus.jackson.map.*, java.util.*, java.io.StringWriter" 
%><%
	// NOTE:
	// 		hackish! We bump up the page buffer size to something nutty was a
	// 		way of ensuring that we canoutput lots of rows and still set the
	// 		timing cookie at the end

	long startTime = Calendar.getInstance().getTimeInMillis();

	Integer start = 0;
	if(null != request.getParameter("start")){
		start = Integer.parseInt(request.getParameter("start"));
	}
	Integer count = 5000;
	if(null != request.getParameter("rows")){
		count = Integer.parseInt(request.getParameter("rows"));
	}else if(null != request.getParameter("count")){
		count = Integer.parseInt(request.getParameter("count"));
	}

	String output = "json";
	if(null != request.getParameter("output")){
		output = request.getParameter("output");
	}

	// set up the data

	// note, we seed our Random with some number to ensure that we always
	// re-generate *the same* data for every run. The Java spec is very
	// particular about the stability of the results:
	//
	//		http://java.sun.com/j2se/1.4.2/docs/api/java/util/Random.html
	//
	final Random rand = new Random(392092);
	
	
	final String[] _classOfWorker = {
		"Not in universe",
		"Never worked",
		"Private",
		"Self-employed-not incorporated",
		"State government",
		"Local government",
		"Federal government",
	};

	final String[] _education = {
		"Children",
		"Less than 1st grade",
		"1st 2nd 3rd or 4th grade",
		"5th or 6th grade",
		"7th and 8th grade",
		"9th grade",
		"10th grade",
		"11th grade",
		"12th grade no diploma",
		"High school graduate",
		"Some college but no degree",
		"Associates degree-occup /vocational",
		"Associates degree-academic program",
		"Bachelors degree(BA AB BS)",
		"Masters degree(MA MS MEng MEd MSW MBA)",
		"Doctorate degree(PhD EdD)",
		"Prof school degree (MD DDS DVM LLB JD)",
	};

	final String[] _maritalStatus = {
		"Never married",
		"Married-civilian spouse present",
		"Divorced",
	};

	final String[] _race = {
		"Black",
		"White",
		"Asian or Pacific Islander",
		"Latino",
		"Amer Indian Aleut or Eskimo",
		"Other",
	};

	final String[] _sex = {
		"Male",
		"Female",
	};

	// create a list of items
	ArrayList items = new ArrayList(count);
	pageContext.setAttribute("items", items); // ensure that JSTL can access our list
	for(int x=0; x<(count+start); x++){
		HashMap item = new HashMap();
		Integer age = rand.nextInt( 110 );
		item.put("id", x);
		item.put("age", age);
		item.put("class", _classOfWorker[ rand.nextInt( _classOfWorker.length ) ]);
		item.put("education", _education[ rand.nextInt( _education.length ) ]);
		item.put("maritalStatus", _maritalStatus[ rand.nextInt( _maritalStatus.length ) ]);
		item.put("race", _race[ rand.nextInt( _race.length ) ]);
		item.put("sex", _sex[ rand.nextInt( _sex.length ) ]);
		if(age < 18){ // sanity checks
			item.put("class", _classOfWorker[ 0 ]);
			item.put("maritalStatus", _maritalStatus[ 0 ]);
		}
		if(x>=start){
			items.add(item);
		}
	}

	// now output the list based on the request type:
	
	//////////////////////////////////////
	//	JSON
	//
	if(output.equals("json")){
		response.setContentType("text/plain");

		JsonFactory jf = new JsonFactory();
		StringWriter sw = new StringWriter();
		JsonGenerator gen = jf.createJsonGenerator(sw);
		new JavaTypeMapper().writeAny(gen, items);
		out.println(sw.toString());
	}

	//////////////////////////////////////
	//	JSON COMPACT
	//
	if(output.equals("json-compact")){
		response.setContentType("text/plain");

%>
[
	[ 
		"id", "age", "class", "education", "maritalStatus", 
		"race", "sex", "class", "maritalStatus"
	], 
<c:forEach var="item" items="${items}" varStatus="itemStatus">[
"<c:out value="${item.id}" escapeXml="false" />", "<c:out value="${item.age}" escapeXml="false" />", "<c:out value="${item.class}" escapeXml="false" />", "<c:out value="${item.education}" escapeXml="false" />", "<c:out value="${item.maritalStatus}" escapeXml="false" />", "<c:out value="${item.race}" escapeXml="false" />", "<c:out value="${item.sex}" escapeXml="false" />" 
],</c:forEach>
	[]
]
<%
	}

	//////////////////////////////////////
	//	HTML
	//
	if(output.equals("html")){
		response.setContentType("text/html");

		// response.setHeader("Vary", "Accept-Encoding");
		// response.setHeader("Content-Encoding", "gzip");
%>
<table id="dataTable">
	<tbody>
		<c:forEach var="item" items="${items}" varStatus="itemStatus">
			<tr>
				<td><c:out value="${item.id}" escapeXml="false" /></td>
				<td><c:out value="${item.age}" escapeXml="false" /></td>
				<td><c:out value="${item.class}" escapeXml="false" /></td>
				<td><c:out value="${item.education}" escapeXml="false" /></td>
				<td><c:out value="${item.maritalStatus}" escapeXml="false" /></td>
				<td><c:out value="${item.race}" escapeXml="false" /></td>
				<td><c:out value="${item.sex}" escapeXml="false" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<%
	}

	//////////////////////////////////////
	//	XML
	//
	if(output.equals("xml")){
		response.setContentType("text/xml");
%><?xml version="1.0" encoding="UTF-8"?>

<list>
	<c:forEach var="item" items="${items}" varStatus="itemStatus">
		<item>
			<itemId><c:out value="${item.id}" /></itemId>
			<age><c:out value="${item.age}" /></age>
			<classOfWorker><c:out value="${item.class}" /></classOfWorker>
			<education><c:out value="${item.education}" /></education>
			<maritalStatus><c:out value="${item.maritalStatus}" /></maritalStatus>
			<race><c:out value="${item.race}" /></race>
			<sex><c:out value="${item.sex}" /></sex>
		</item>
	</c:forEach>
</list>
<%
	}


	//////////////////////////////////////
	//	SOAP
	//
	if(output.equals("xml")){
		response.setContentType("text/xml");
%><?xml version="1.0" encoding="UTF-8"?>

<list>
	<c:forEach var="item" items="${items}" varStatus="itemStatus">
		<item>
			<itemId><c:out value="${item.id}" /></itemId>
			<age><c:out value="${item.age}" /></age>
			<classOfWorker><c:out value="${item.class}" /></classOfWorker>
			<education><c:out value="${item.education}" /></education>
			<maritalStatus><c:out value="${item.maritalStatus}" /></maritalStatus>
			<race><c:out value="${item.race}" /></race>
			<sex><c:out value="${item.sex}" /></sex>
		</item>
	</c:forEach>
</list>
<%
	}

	//////////////////////////////////////
	//	Finalization
	//
	long endTime = Calendar.getInstance().getTimeInMillis();
	Cookie c = new Cookie("serverExecTime", (new Long(endTime-startTime)).toString());
	response.addCookie(c);
%>
