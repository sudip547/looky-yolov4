const video = document.getElementById('video');
const canvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');

let detecting = false;

navigator.mediaDevices.getUserMedia({ video: true }).then(stream => {
  video.srcObject = stream;
  video.onloadedmetadata = () => {
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    video.play();
    startDetectionLoop();
  };
});

function startDetectionLoop() {
  setInterval(() => {
    if (!detecting) {
      detectFrame();
    }
  }, 100); // adjust for faster/slower detection
}

function detectFrame() {
  detecting = true;

  const tempCanvas = document.createElement('canvas');
  tempCanvas.width = video.videoWidth;
  tempCanvas.height = video.videoHeight;
  const tempCtx = tempCanvas.getContext('2d');
  tempCtx.drawImage(video, 0, 0);
  tempCanvas.toBlob(blob => {
    const formData = new FormData();
    formData.append("file", blob, "frame.jpg");

    fetch("http://localhost:8000/detect", {
      method: "POST",
      body: formData
    })
    .then(res => res.json())
    .then(data => {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
      data.results.forEach(obj => {
        const [x1, y1, x2, y2] = obj.box;
        ctx.strokeStyle = "#00FF00";
        ctx.lineWidth = 2;
        ctx.strokeRect(x1, y1, x2 - x1, y2 - y1);
        ctx.font = "16px Arial";
        ctx.fillStyle = "#00FF00";
        ctx.fillText(`${obj.label} (${obj.confidence}%)`, x1 + 5, y1 - 5);
      });
      detecting = false;
    })
    .catch(() => {
      detecting = false;
    });
  }, 'image/jpeg');
}
