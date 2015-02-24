$(document).ready(function(){
	
	$("body").on("click","#botonAjax", function(event){
		var id = $(this).data("objid");
		var url = "mensajes/"+id;
		$.ajax({
			type:'POST',
			headers: {Accept: 'application/json'},
			url: url,
			data: {},
			success: function(data) {
				$("#campoId").html(data.id);
				$("#formId").val(data.id);
				$("#campoAutor").html(data.autor);
				$("#formAutor").val(data.autor);
				$("#formTexto").val(data.texto);
				$("#formFechaPublicacion").val(data.fechaPublicacion);
				$("#campoVersion").html(data.version);
				$("#formVersion").val(data.version);
				//$("#contenedorFormulario").show();
			}
		});
	});

	$("body").on("click","#botonBorrarFormulario", function(event){
		$("#campoId").html("");
		$("#formId").val("");
		$("#campoAutor").html("");
		$("#formAutor").val("");
		$("#formTexto").val("");
		$("#formFechaPublicacion").val("");
		$("#campoVersion").html("");
		$("#formVersion").val("");
		
	});
	
	$("body").on("click","#botonAjaxBorrar", function(event){
		var id = $(this).data("objid");
		var url = "mensajes/"+id;
		$.ajax({
			type:'DELETE',
			headers: {Accept: 'application/json'},
			url: url,
			data: {},
			success: function() {},
			complete: function() {
				cargarLista();
			}
		});
	});

	$("body").on("click","#botonAjaxAgregar", function(event){
		var texto = $("#formTexto").val();
		var url = "mensajes/";
		var data = JSON.stringify({texto: texto});
		$.ajax({
			type:'POST',
			contentType: 'application/json',
			headers: {Accept: 'application/json'},
			url: url,
			data: data,
			success: function() {},
			complete: function() {
				cargarLista();
			}
		});
	});

	$("body").on("click","#botonAjaxEditar", function(event){
		var id = $("#formId").val();
		
		var texto = $("#formTexto").val();
		
		var version = $("#formVersion").val();
		var url = "mensajes/"+id;
		//var data = "{'id':"+id+",'nombre':'"+nombre+"','documento':'"+documento+"', 'version':"+version+"}";
		var data = JSON.stringify(data = {id: id, texto:texto,  version: version});
		$.ajax({
			type:'PUT',
			headers: {Accept: 'application/json'},
			url: url,
			data: data,
			success: function() {},
			complete: function() {
				cargarLista();
			}
		});
	});		
	
	
	
	
	
	function cargarLista(){
		var url = "mensajes/getAll";
		$.ajax({
			type:'GET',
			headers: {Accept: 'application/json'},
			url: url,
			data: {},
			success: function(data) {
				var datoHTML = "<tr><td>Autor</td><td>Texto</td><td>FechaPublicacion</td><td>Borrar</td><td>Detalles</td></tr>";
				$.each(data, function(i, mensaje){
					datoHTML += "" +
							"<tr>" +
								"<td>"+mensaje.autor.emailAddress+"</td>" +
								"<td>"+mensaje.texto+"</td>" +
								"<td>"+mensaje.fecha+"</td>" +
								"<td><div id='botonAjaxBorrar' class='btn btn-danger' data-objid='"+mensaje.id+"'>Borrar</div></td>" +
								"<td><div id='botonAjaxAgregar' class='btn btn-danger' data-objid='"+mensaje.id+"'>Ver</div></td>" +
							"</tr>";
				});
				$("#contenidoTabla").html(datoHTML);
			}
		});
	}
});

