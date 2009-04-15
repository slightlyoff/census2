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

	// hacked up version of this script for JRS
	Integer start = 0;
	Integer count = 5000;
	Integer total = 5000;
	String[] range;
	if(null != request.getHeader("range")){
		range = request.getHeader("range").split("=")[1].split("-");
		start = Integer.parseInt(range[0]);
		count = Integer.parseInt(range[1]);
	}

	if(null != request.getParameter("total")){
		total = Integer.parseInt(request.getParameter("total"));
	}

	String output = "json-rest";
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

	//////////////////////////////////////
	//	JSON REST
	//
	if(output.equals("json-rest")){
		response.setContentType("text/plain");
		response.setHeader(	"Content-Range", 
							"items "+start.toString()+"-"+count.toString()+"/"+total.toString());

%>
[
<c:forEach var="item" items="${items}" varStatus="itemStatus">{
"id":		"<c:out value="${item.id}" escapeXml="false" />", 
"age":		"<c:out value="${item.age}" escapeXml="false" />", 
"class":	"<c:out value="${item.class}" escapeXml="false" />", 
"education":"<c:out value="${item.education}" escapeXml="false" />", 
"maritalStatus": "<c:out value="${item.maritalStatus}" escapeXml="false" />", 
"race":		"<c:out value="${item.race}" escapeXml="false" />", 
"sex":		"<c:out value="${item.sex}" escapeXml="false" />" 
},</c:forEach>
	{}
]
<%
	}

	//////////////////////////////////////
	//	Finalization
	//
	long endTime = Calendar.getInstance().getTimeInMillis();
	Cookie c = new Cookie("serverExecTime", (new Long(endTime-startTime)).toString());
	response.addCookie(c);
%>
