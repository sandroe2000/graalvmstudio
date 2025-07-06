export class WYSIWYG {

    constructor(app, params){
        this.app = app;
        this.drakeCopy = null;
        this.drakeColOrder = null;
        this.drakeRowOrder = null;
        this.params = params;
    }

    template(){
        return `
        <div id="toolBar" class="tool-bar card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <i class="bi bi-arrows-move" style="font-size: 0.75rem;"></i>
            </div>
            <div class="card-body scrollbar">
                <button type="button" id="btnDragDivContainer" class="btn btn-deep-aside btn-sm mb-1" aria-label="container" title="Container">
                    <i class="bi bi-collection"></i>
                </button>
                <button type="button" id="btnDragDivRow" class="btn btn-deep-aside btn-sm mb-1" aria-label="row" title="Row">
                    <i class="bi bi-layout-sidebar-inset"></i>
                </button>
                <button type="button" id="btnDragDivCol" class="btn btn-deep-aside btn-sm mb-1" aria-label="col" title="Col">
                    <i class="bi bi-layout-three-columns"></i>
                </button>
                <button type="button" id="btnDragTab" class="btn btn-deep-aside btn-sm mb-1" aria-label="tab" title="NavTabs">
                    <i class="bi bi-folder2"></i>
                </button>
                <button type="button" id="btnDragDropdown" class="btn btn-deep-aside btn-sm mb-1" aria-label="dropdown" title="Dropdown">
                    <i class="bi bi-menu-button-fill"></i>
                </button>
                <button type="button" id="btnDragTable" class="btn btn-deep-aside btn-sm mb-1" aria-label="table" title="Table">
                    <i class="bi bi-table"></i>
                </button> 
                <button type="button" id="btnDragCard" class="btn btn-deep-aside btn-sm mb-1" aria-label="card" title="Card">
                    <i class="bi bi-postcard"></i>
                </button>                
                <button type="button" id="btnDragLabel" class="btn btn-deep-aside btn-sm mb-1" aria-label="label"  title="Label">
                    <i class="bi bi-type"></i>
                </button>
                <button type="button" id="btnDragInputText" class="btn btn-deep-aside btn-sm mb-1" aria-label="text"  title="Input Text">
                    <i class="bi bi-input-cursor"></i>
                </button>
                <button type="button" id="btnDragInputGroup" class="btn btn-deep-aside btn-sm mb-1" aria-label="input-group" title="Input Group">
                    <i class="bi bi-vr"></i>
                </button>                
                <button type="button" id="btnDragTextArea" class="btn btn-deep-aside btn-sm mb-1" aria-label="textarea" title="Textarea">
                    <i class="bi bi-textarea-resize"></i>
                </button>
                <button type="button" id="btnDragRadio" class="btn btn-deep-aside btn-sm mb-1" aria-label="radio" title="Radio">
                    <i class="bi bi-record-circle-fill"></i>
                </button>
                <button type="button" id="btnDragCheck" class="btn btn-deep-aside btn-sm mb-1" aria-label="check" title="Check">
                    <i class="bi bi-check-square"></i>
                </button>
                <button type="button" id="btnDragButton" class="btn btn-deep-aside btn-sm mb-1" aria-label="button" title="Button">
                    <i class="bi bi-square-fill"></i>
                </button>                               
            </div>
        </div>
        <div id="propertiesMenu" class="card hide">
            <div class="card-header d-flex justify-content-between align-items-center">
                <i class="bi bi-arrows-move" style="font-size: 0.75rem;"></i>
            </div>
            <div class="card-body scrollbar"></div>
        </div>
        <div class="dragula-panel" id="dragulaPanel-${this.params.id}"></div>`;
    }

    async init(){

        this.app.utils.dragElement(document.querySelector('#toolBar'));
        this.app.utils.dragElement(document.querySelector('#propertiesMenu'));
        this.startDragula();
        if(this.params && this.params?.code){
            let dragulaPanel = document.querySelector(`#dragulaPanel-${this.params.id}`);
                dragulaPanel.insertAdjacentHTML('afterbegin', this.params?.code);
            this.loadContainers(dragulaPanel);
        }
        //await this.createtoolBar();
        await this.events();
    }

    startDragula(){
        let dragulaPanel = document.querySelector(`#dragulaPanel-${this.params.id}`);
        this.drakeCopy = dragula([document.querySelector('div#toolBar div.card-body'), dragulaPanel], {
            revertOnSpill: true,
            copy: (el, source) => {
               return source === document.querySelector('div#toolBar div.card-body');
            },
            accepts: (el, target) => {
                //TODO: VALIDAR ESTAS REGRAS
                /*if (target.getAttribute('id')==`dragulaPanel-${this.params.id}` && el.getAttribute('aria-label')=='container'){
                    return true;
                } else if (target.hasAttribute('class') && target.getAttribute('class').indexOf('row') > -1 && el.getAttribute('aria-label')=='col'){
                    return true;
                } else if (target.hasAttribute('class') && target.getAttribute('class').indexOf('row') > -1 &&  el.hasAttribute('class') && target.getAttribute('class').indexOf('col') > -1) {
                    return true;
                }else if (target.hasAttribute('class') && target.getAttribute('class').indexOf('col') > -1) {
                    return true;
                }*/
                return true;
            }
        }).on('drop', (el, target, source, sibling) => {
            this.addField(el, target, sibling);
            target.removeChild(el);
        });

        this.drakeColOrder = dragula([dragulaPanel]);
        this.drakeRowOrder = dragula([dragulaPanel]);
    }

    loadContainers(node){
        this.recursiveThis(node, this.setContainer, this);
    }

    setFocus(id){
        this.focus = document.querySelector(`[id="${id}"]`);
        this.clearInFocus();        
        this.focus.closest('div').classList.add('in-focus');
    }

    clearInFocus(){
        document.querySelectorAll(`#dragulaPanel-${this.params.id} div`).forEach(element => {
            element.classList.remove('in-focus');
        });
    }

    clearAttributes(){
        document.querySelector('#frmField')?.reset();
    }

    setRows(){
        if(['textarea', 'select-multiple'].includes(this.focus.type)){
            document.querySelector('#frmField_rows').disabled = false;
            if(this.focus.type=='textarea'){
                document.querySelector('#frmField_rows').value = this.focus.getAttribute('rows');
            }
            if(this.focus.type=='select-multiple'){
                document.querySelector('#frmField_rows').value = this.focus.getAttribute('size');
            }

            document.querySelector('#frmField_rows').addEventListener('input', (event) => {
                if(this.focus.type=='textarea'){
                    this.focus.setAttribute('rows', document.querySelector('#frmField_rows').value);
                }
                if(this.focus.type=='select-multiple'){
                    this.focus.setAttribute('size', document.querySelector('#frmField_rows').value);
                }
            });
        }else{
            document.querySelector('#frmField_rows').disabled = true;
            document.querySelector('#frmField_rows').value = '';
        }
    }
    removeOnActive(node){

        if( node.nodeType === 1 && node.hasAttribute('class')){
            node.classList.remove('on-active');
        }
    }

    addField(el, target, sibling){

        if(!el.hasAttribute('aria-label')) return false;

        let id = this.app.utils.uuidv4();
        let str = '';

        switch (el.getAttribute('aria-label')) {
            case 'container':
                str = this.getContainer(id);
                break;
            case 'row':
                str = this.getRow(id);
                break;
            case 'col':
                str = this.getCol(id);
                break;
            case 'label':
                str = this.getLabel(id);
                break;
            case 'text':
                str = this.getInputText(id);
                break;
            case 'button':
                str = this.getButton(id);
                break;
            case 'tab':
                str = this.getTab(id);
                break;
            case 'dropdown':
                str = this.getDropdown(id);
                break;
        }
        //console.log(sibling);
        if(sibling){
            sibling.insertAdjacentHTML('beforebegin', str);
        }else{
            target.insertAdjacentHTML('beforeend', str);
        }
        this.setContainer(document.querySelector(`#${id}`), this);
        document.querySelector(`#${id}`).closest('div').click();
    }

    setContainer(node, that){
        let _new = node;
        if(_new != null 
            && _new.nodeType === 1 
            && _new.hasAttribute('class') 
            && _new.getAttribute('class').indexOf('container') > -1) {
                that.drakeCopy.containers.push(_new);
                that.drakeColOrder.containers.push(_new);
        }
        if(_new != null 
            && _new.nodeType === 1 
            && _new.hasAttribute('class') 
            && _new.getAttribute('class').indexOf('row') > -1) {
                that.drakeCopy.containers.push(_new);
                that.drakeColOrder.containers.push(_new);
        }
        if(_new != null 
            && _new.nodeType === 1 
            && _new.hasAttribute('class') 
            && _new.getAttribute('class').indexOf('col') > -1) {
                that.drakeCopy.containers.push(_new);
                that.drakeRowOrder.containers.push(_new);
                that.felipeSugar(_new);  
        }
    }

    //FELIPE ODEIA PROCURAR INPUT HIDDEN NO OMNI, RSRSRSR
    felipeSugar(_new){
        if(_new.querySelector('span[class*="badge"]')){
            _new.removeChild(_new.querySelector('span[class*="badge"]'));
        }
        if(_new.querySelectorAll('input[type="hidden"]').length > 0 && !_new.querySelector('.badge')){
            let badge = '<span class="badge text-bg-warning z-3">h</span>';
            _new.insertAdjacentHTML('beforeend', badge);
        }
    }

    getContainer(id){
        return `<div id="${id}" class="container"></div>`;
    }

    getRow(id){
        return `<div id="${id}" class="row"></div>`;
    }

    getCol(id){
        return `<div id="${id}" class="col-md-4"></div>`;
    }

    getLabel(id){
        return `<label id="${id}" class="form-label" contenteditable="true">Change this label</label>`;
    }

    getInputText(id){
        return `<input type="text" id="${id}" class="form-control" />`;
    }

    getButton(id){
        return `<button type="button" id="${id}" class="btn btn-primary">Primary</button>`;
    }

    getTab(id){
        return `
            <nav>
                <div class="nav nav-tabs" id="navTab${id}" role="tablist">
                    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Home</button>
                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Profile</button>
                </div>
            </nav>
            <div class="tab-content" id="tabContent${id}">
                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0"><h1>Home</h1></div>
                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0"><h1>Profile</h1></div>
            </div>`;
    }

    getDropdown(id){
        return `
            <div class="dropdown">
                <button id="${id}" class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Dropdown button
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">Action</a></li>
                    <li><a class="dropdown-item" href="#">Another action</a></li>
                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                </ul>
            </div>`;
    }

    recursive(node, func) {
        func(node);
        node = node.firstChild;
        while (node) {
            this.recursive(node, func);
            node = node.nextSibling;
        }
    }
    recursiveThis(node, func, that) {
        func(node, that);
        node = node.firstChild;
        while (node) {
            that.recursiveThis(node, func, that);
            node = node.nextSibling;
        }
    }

    async events(){

        let dragulaPanel = document.querySelector(`#dragulaPanel-${this.params.id}`);

        document.addEventListener('keydown', async (event) => {

            event.stopPropagation();
            //event.preventDefault();

            if(event.key == 'Delete' && document.querySelector('.on-active')){
                const onActive = document.querySelector('.on-active');
                if(onActive.getAttribute('id')==`dragulaPanel-${this.params.id}`) return false;
                onActive.parentNode.removeChild(onActive);
            }

            if (event.ctrlKey && (event.key === 'c' || event.key === 'C')) {
                if(document.querySelector('.on-active') && document.querySelector('.on-active').getAttribute('id') != `dragulaPanel-${this.params.id}`){
                    const onActive = document.querySelector('.on-active');
                    navigator.clipboard.writeText(onActive.outerHTML);
                }
            }

            if (event.ctrlKey && (event.key === 'v' || event.key === 'V')) {
                if(document.querySelector('.on-active')){
                    const onActive = document.querySelector('.on-active');
                    const clipboard = await navigator.clipboard.readText();
                    onActive.insertAdjacentHTML('beforeend', clipboard);
                    this.recursiveThis(dragulaPanel, this.setContainer, this);
                }
            }

            if (event.ctrlKey && (event.key === 'z' || event.key === 'Z')) {
                console.log('UNDO...');
            }

            if (event.ctrlKey && (event.key === 'y' || event.key === 'Y')) {
                console.log('REDO...');
            }
        });

        dragulaPanel.addEventListener('click', (event) => {

            event.stopPropagation();
            event.preventDefault();

            let menu = document.querySelector('#propertiesMenu');
                menu.classList.add('hide');
                menu.style.top = '0px';
                menu.style.left = '0px';

            this.recursive(dragulaPanel, this.removeOnActive);
            event.target.classList.add('on-active');
        });

        dragulaPanel.addEventListener('contextmenu', async (event) => {
            event.preventDefault();

            if(event.target.getAttribute('id')=='dragulaPanel') return false;

            this.recursive(dragulaPanel, this.removeOnActive);
            event.target.classList.remove('on-active'); 
            
            let contextMenuH = document.querySelector('#propertiesMenu').offsetHeight || 280;
            let contextMenuW = document.querySelector('#propertiesMenu').offsetWidth || 450;

            let w = window.innerWidth;
            let h = window.innerHeight;
            let y = event.clientY + contextMenuH > h ? event.clientY - contextMenuH : event.clientY;
            let x = event.clientX + contextMenuW > w ? event.clientX - contextMenuW : event.clientX;
            let menu = document.querySelector('#propertiesMenu');
                menu.style.top = `${y}px`;
                menu.style.left = `${x}px`;
                menu.classList.remove('hide');

            await this.app.initLocal({
                target: '#propertiesMenu .card-body',
                path: '/js/properties/Properties.js',
                app: true,
                params: event.target
            });

        }, false);
    }
}