export class Container {

    constructor(app, element){
        this.app = app;
        this.element = element;
        this.currentId = element?.getAttribute('id') || this.app.utils.uuidv4();
        this.currentClass = element?.getAttribute('class') || "";
        this.currentStyle = element?.getAttribute('style') || "";
    }

    template(){
        return `
        <div class="container">
            <h5 class="mb-3">Row</h5>
            <div class="row mb-2">
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">id</label>
                <div class="col-md-8">
                    <input type="text" class="form-control form-control-sm" id="colId" value="${this.currentId}" readonly>
                </div>
            </div>
            <div class="row mb-2">              
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">class</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control form-control-sm" id="colClass" value="${this.currentClass.replace('on-active', '').trim()}" /> 
                </div>               
            </div>
            <div class="row mb-2">
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">style</label>
                <div class="col-md-8">
                    <textarea class="form-control form-control-sm" rows="5" id="colStyle">${this.currentStyle}</textarea>
                </div>
            </div>
        </div>`;
    }

    async init(){
        await this.events();
    }

    async events(){
        document.querySelector('#colStyle').addEventListener('change', (event) => {
            this.element.setAttribute('style', event.target.value);
        });
        document.querySelector('#colClass').addEventListener('change', (event) => {
            this.element.setAttribute('class', event.target.value);
        });
    }
}