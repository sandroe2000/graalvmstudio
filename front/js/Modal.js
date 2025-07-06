export class Modal {

    constructor(){
        this.modal = null;               
    }

    async init(params){
        this.params = params;
        let appModal = document.querySelector('#appModal');
        this.modal = new bootstrap.Modal(appModal);
        if(this.params?.size) appModal.querySelector('.modal-dialog').classList.add(this.params.size);
        if(this.params?.label) appModal.querySelector('#appModalLabel').innerHTML = this.params.label;
        this.modal.show();
        this.events();
    }

    events(){

        document.querySelectorAll('.closeModal').forEach(element => {
            element.addEventListener('click', (event) => {
                this.close();
            });
        });

        this.modal._element?.addEventListener('hidden.bs.modal', event => {
            if(this.params?.size) appModal.querySelector('.modal-dialog').classList.remove(this.params.size);
            if(this.params?.label) appModal.querySelector('#appModalLabel').innerHTML = 'Modal title';
        });
    }

    close(){
        this.modal.hide();                
        let backDrop = document.querySelector('.modal-backdrop');
        if(backDrop) backDrop.remove();
    }
}