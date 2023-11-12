package service;

import java.util.List;
import images.*;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import model.DetalleVenta;
import model.Venta;
import repository.Conexion;
import repository.DetalleVentaRepository;
import repository.VentaRepository;

public class PdfTicket {

	VentaRepository ventaRepository = new Conexion();

	DetalleVentaRepository detalleVentaRepository = new Conexion();

	public static void main(String[] args) {
		String pdfFilePath = "output.pdf";

		try {
			// generatePdf(pdfFilePath);
			System.out.println("PDF creado con éxito en: " + pdfFilePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void generatePdf(HttpServletResponse response, int id) throws Exception {
		// Configura la respuesta para ser un PDF
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "inline; filename=ticket.pdf");

		// Obtiene el OutputStream de la respuesta
		ServletOutputStream out = response.getOutputStream();

		// Crea un objeto Document
		Document document = new Document(new Rectangle(260f, 720f)); // Ajusta según tus necesidades
		Venta ventaOBJ = ventaRepository.findById(id);
		System.out.println("Venta: " + ventaOBJ.getFecha());
		List<DetalleVenta> detallesVenta = detalleVentaRepository.obtenerDetalleByVentaId(id);

		System.out.println("detallesVenta: " + detallesVenta);
		// Inicializa un objeto PdfWriter con el OutputStream
		PdfWriter.getInstance(document, out);

		// Abre el documento para escribir
		document.open();

		
		 // Agrega el logo al documento
	    Image logo = Image.getInstance("https://static.wixstatic.com/media/6d2554_ac65608d30e640548e474f812b892a4e.png/v1/fill/w_280,h_254,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/6d2554_ac65608d30e640548e474f812b892a4e.png"); // Reemplaza con la ruta de tu logo
	    logo.scaleToFit(70, 70); // Ajusta el tamaño del logo según tus necesidades
	    logo.setAlignment(Image.ALIGN_CENTER);
	    document.add(logo);
	    
	    
		// Crea un objeto Font con un tamaño específico para el texto regular
		Font regularFont = new Font(Font.FontFamily.TIMES_ROMAN, 10);

		// Crea un objeto Font con un tamaño más pequeño para los detalles de la tabla
		Font smallFont = new Font(Font.FontFamily.TIMES_ROMAN, 9);

		// Agrega contenido al PDF
		 Paragraph title = new Paragraph("TICKET DE VENTA", regularFont);
         title.setAlignment(Paragraph.ALIGN_CENTER);  // Alinea el texto al centro
         document.add(title);  // Agrega el título al documento
 		document.add(new Paragraph(" "));
         
         Paragraph fecha = new Paragraph("Fecha: " + ventaOBJ.getFecha(), regularFont);
         fecha.setAlignment(Paragraph.ALIGN_RIGHT);  // Alinea el texto a la izquierda
        
         
         document.add(fecha);

		// espacio entre la fecha y la tabla
		document.add(new Paragraph(" "));
		// Crea la tabla
		PdfPTable table = new PdfPTable(5); // 5 columnas
		table.setWidthPercentage(115);

		// encabezados de la tabla
		PdfPCell headerCell = new PdfPCell(new Phrase("Código", smallFont));
		table.addCell(headerCell);

		headerCell = new PdfPCell(new Phrase("Producto", smallFont));
		table.addCell(headerCell);

		headerCell = new PdfPCell(new Phrase("Cantidad", smallFont));
		table.addCell(headerCell);

		headerCell = new PdfPCell(new Phrase("Precio", smallFont));
		table.addCell(headerCell);

		headerCell = new PdfPCell(new Phrase("SubTotal", smallFont));
		table.addCell(headerCell);

		// Agrega los detalles de la venta en filas de la tabla
		for (DetalleVenta detalle : detallesVenta) {

			PdfPCell cell = new PdfPCell(new Phrase(detalle.getCodigo(), smallFont));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase(detalle.getProducto(), smallFont));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase(String.valueOf(detalle.getCantidad()), smallFont));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase(String.valueOf(detalle.getPrecioVenta()), smallFont));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase(String.valueOf(detalle.getPrecioVenta() * detalle.getCantidad()), smallFont));
			table.addCell(cell);
		}

		// Agrega la tabla al documento
		document.add(table);
		Paragraph total = new Paragraph("TOTAL: " + ventaOBJ.getTotal());
		total.setAlignment(Paragraph.ALIGN_RIGHT);
		// Agrega el total
		document.add(total);

		// Cierra el documento
		document.close();
		out.close();
	}

}
