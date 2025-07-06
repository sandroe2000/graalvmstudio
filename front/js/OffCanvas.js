export class OffCanvas {

    constructor(){
        this.offcanvas = null;                
    }

    async init(params){
        this.params = params;
        let appOffCanvas = document.querySelector('#appOffCanvas');
        this.offcanvas = bootstrap.Offcanvas.getInstance(appOffCanvas);            
       
        if (!this.offcanvas) {
            this.offcanvas = new bootstrap.Offcanvas(appOffCanvas);
        } 

        if(this.params?.label) appOffCanvas.querySelector('#appOffCanvasLabel').innerHTML = this.params.label;
        this.offcanvas.show();
        this.events();
    }

    events(){

        document.querySelectorAll('.closeModal').forEach(element => {
            element.addEventListener('click', (event) => {
                this.close();
            });
        });
    }

    close(){
        this.offcanvas.hide();                
    }
}