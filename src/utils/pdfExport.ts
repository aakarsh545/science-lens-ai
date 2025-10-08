import jsPDF from "jspdf";

interface Message {
  role: "user" | "assistant";
  content: string;
  created_at: string;
}

export function exportChatToPDF(
  messages: Message[],
  chatTitle: string,
  topic?: string
) {
  const doc = new jsPDF();
  const pageWidth = doc.internal.pageSize.getWidth();
  const pageHeight = doc.internal.pageSize.getHeight();
  const margin = 20;
  const maxWidth = pageWidth - 2 * margin;
  let yPosition = margin;

  // Header
  doc.setFontSize(20);
  doc.setFont("helvetica", "bold");
  doc.text("Science Lens AI", margin, yPosition);
  
  yPosition += 10;
  doc.setFontSize(16);
  doc.text(chatTitle, margin, yPosition);
  
  if (topic) {
    yPosition += 8;
    doc.setFontSize(12);
    doc.setFont("helvetica", "normal");
    doc.text(`Topic: ${topic}`, margin, yPosition);
  }

  yPosition += 8;
  doc.setFontSize(10);
  doc.text(`Exported: ${new Date().toLocaleDateString()}`, margin, yPosition);
  
  // Line separator
  yPosition += 5;
  doc.setDrawColor(200, 200, 200);
  doc.line(margin, yPosition, pageWidth - margin, yPosition);
  yPosition += 10;

  // Messages
  messages.forEach((message, index) => {
    const isUser = message.role === "user";
    
    // Check if we need a new page
    if (yPosition > pageHeight - 40) {
      doc.addPage();
      yPosition = margin;
    }

    // Message header
    doc.setFontSize(11);
    doc.setFont("helvetica", "bold");
    if (isUser) {
      doc.setTextColor(59, 130, 246);
    } else {
      doc.setTextColor(139, 92, 246);
    }
    doc.text(isUser ? "You:" : "AI:", margin, yPosition);
    
    yPosition += 6;
    
    // Message content
    doc.setFont("helvetica", "normal");
    doc.setTextColor(0, 0, 0);
    doc.setFontSize(10);
    
    const lines = doc.splitTextToSize(message.content, maxWidth);
    for (const line of lines) {
      if (yPosition > pageHeight - 30) {
        doc.addPage();
        yPosition = margin;
      }
      doc.text(line, margin, yPosition);
      yPosition += 5;
    }
    
    // Timestamp
    doc.setFontSize(8);
    doc.setTextColor(128, 128, 128);
    const timestamp = new Date(message.created_at).toLocaleString();
    doc.text(timestamp, margin, yPosition);
    
    yPosition += 8;
    
    // Separator between messages
    if (index < messages.length - 1) {
      doc.setDrawColor(230, 230, 230);
      doc.line(margin, yPosition, pageWidth - margin, yPosition);
      yPosition += 8;
    }
  });

  // Save the PDF
  const filename = `${chatTitle.replace(/[^a-z0-9]/gi, '_').toLowerCase()}_${Date.now()}.pdf`;
  doc.save(filename);
}
