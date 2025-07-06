export class Properties {

    constructor(app, params){
        this.app = app;
        this.params = params;
    }

    template(){
        return "<div id='propertiesBody' style='overflow: auto'></div>";
    }

    async init(){

        let element = this.params;
        let tagName = element.tagName;        
        document.querySelector('#propertiesBody').innerHTML = '';

        switch (tagName) {
            case 'DIV':
                if(element.classList.contains('container') || element.classList.contains('container-fluid')){
                    await this.app.initLocal({
                        path: '/js/properties/Container.js',
                        target: '#propertiesBody',
                        params: element
                    });
                }else if(element.classList.contains('row')){
                    await this.app.initLocal({
                        path: '/js/properties/Row.js',
                        target: '#propertiesBody',
                        params: element
                    });
                }else if(element.getAttribute("class").indexOf("col-") > -1){
                    await this.app.initLocal({
                        path: '/js/properties/Col.js',
                        target: '#propertiesBody',
                        params: element
                    });
                }
                break;
            case 'INPUT':
                console.log("Properties init INPUT", element);
                break;
            case 'LABEL':
                console.log("Properties init LABEL", element);
                break;
        }
    }
}