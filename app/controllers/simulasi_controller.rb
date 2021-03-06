class SimulasiController < ApplicationController
    def index
        @tabungan = []
        @params = params[:person]
        
    end
    
    def create
        
        target      = params[:person][:target].to_i
        setor_awal  = params[:person][:setor_awal].to_i
        setoran     = params[:person][:setor_rutin].to_i
        bunga       = params[:person][:bunga]
        periode     = params[:person][:periode].to_i

        array = []

        no = 0
        
        while setor_awal < target || no < periode
            
                setor       = no == 0 ? 0 : setoran
                bunga       = (setor_awal + setor) * 0.25 / 100
                pajak       = bunga * 20 / 100
                admin       = 5000
                total       = setor_awal + bunga - pajak - admin + setor
                flag        = total > target && setor_awal < target ? true : false
                array[no]   = [setor_awal, setor, bunga, pajak, admin, total, no + 1, flag]
                setor_awal  = total
                
            no += 1
        end

        @tabungan   = array
        @params     = params[:person]
        
        render 'index'
        

    end

end