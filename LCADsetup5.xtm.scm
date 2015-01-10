;;;; Much of the content in this file is taken from various Extempore
;;;; blog posts by Ben Swift which are indexed here:
;;;;   http://benswift.me/extempore-docs/index.html
;;;;

;;; Load the needed libraries -- this will take several minutes
;;;

(sys:set-default-timeout (* 2 13953200))
(sys:load "libs/core/instruments.xtm")
(sys:load "libs/core/pc_ivl.xtm")
(sys:load "libs/external/instruments_ext.xtm")

;;; Set up the constants we're going to need
;;;
(define sample-path "/Users/jasonlevine/Code/extempore/assets/")
(define drum-path (string-append sample-path "salamander/OH/"))
(define edrum-path (string-append sample-path "biolabsDubstepKit3/"))
(define conga-path (string-append sample-path "Conga/"))
(define doumbek-path (string-append sample-path "Doumbek/"))
(define djembe-path (string-append sample-path "Djembe/"))
(define jawharp-path (string-append sample-path "Jaw_Harp/"))


;;; Add the samplers/instruments we're going to need to the dsp output
;;; callback
;;;
(define-sampler drums sampler_note_hermite_c sampler_fx)
(define-sampler edrums sampler_note_hermite_c sampler_fx)
(define-sampler conga sampler_note_hermite_c sampler_fx)
(define-sampler doumbek sampler_note_hermite_c sampler_fx)
(define-sampler djembe sampler_note_hermite_c sampler_fx)
(define-sampler jawharp sampler_note_hermite_c sampler_fx)

(define-sampler piano sampler_note_hermite_c sampler_fx)
(define-sampler guitar sampler_note_hermite_c sampler_fx)

(define-instrument subbass subbass_note_c subbass_fx)
(define-instrument sawbass sawbass_note_c sawbass_fx)
(define-instrument fuzzbass fuzz_bass_note_c fuzz_bass_fx)
(define-instrument fmsynth fmsynth_note_c fmsynth_fx)

(bind-func dsp:DSP 1000000
  (let ((delayl (delay_c (convert (* SAMPLERATE 0.5))))
  (delayr (delay_c (convert (* SAMPLERATE 0.43333333)))))
  (lambda (in time chan dat)
    (cond ((< chan 2)
           (+ (delayl (doumbek in time chan dat) 0.0 0.5)
           (edrums in time chan dat) 
            (drums in time chan dat)
            (djembe in time chan dat)
            (conga in time chan dat)
             (delayl (piano in time chan dat) 0.5 0.5)
              (fuzzbass in time chan dat)
              (fmsynth in time chan dat)
              (sawbass in time chan dat)
              (delayr (guitar in time chan dat) 0.3 0.5)))
          (else 0.0)))))

; (bind-func dsp:DSP 1000000
;   (lambda (in time chan dat)
;     (cond ((< chan 2)
;            (+ 
;            (edrums in time chan dat) 
;             (drums in time chan dat)
;             (djembe in time chan dat)
;             (conga in time chan dat)
;              (piano in time chan dat)
;             (guitar in time chan dat)))
;           (else 0.0))))

; (dsp:set! dsp)

;;; Set up drum samples
;;;
(define add-drum-sample
  (lambda (file-name const-name)
    (set-sampler-index drums
                       (string-append drum-path file-name)
                       const-name
                       0 0 0 1)))

(define drum-sample-data
  (list
    (list "kick_OH_F_9.wav" 10)
    (list "kick2_OH_F_9.wav" 11)
    (list "loTom_OH_FF_8.wav" 12)
    (list "hiTom_OH_FF_6.wav" 13)
    (list "hihatClosed_OH_F_20.wav" 20)
    (list "hihatFoot_OH_MP_12.wav" 22)
    (list "hihatOpen_OH_FF_6.wav" 23)
    (list "hihatSemiOpen1_OH_F_1.wav" 24)
    (list "ride1_OH_MP_7.wav" 30)
    (list "ride1Bell_OH_F_6.wav" 31)
    (list "ride2_OH_FF_5.wav" 32)
    (list "ride2Bell_OH_F_6.wav" 33)
    (list "ride2Crash_OH_MP_2.wav" 34)
    (list "ride2CrashChoke_OH_F_1.wav" 35)
    (list "cowbell_FF_6.wav" 36)
    (list "bellchime_F_3.wav" 37)
    (list "snare_OH_FF_1.wav" 40)
    (list "snare_OH_Ghost_1.wav" 41)
    (list "snareOFF_OH_P_6.wav" 42)
    (list "snare2_OH_FF_8.wav" 43)
    (list "snare2_OH_Ghost_1.wav" 44)
    (list "snare2OFF_OH_P_6.wav" 45)
    (list "snareStick_OH_F_1.wav" 46)))


(play-note (now) drums 37 180 44100)

(define add-drum-samples
  (lambda (data)
    (map (lambda (sample-pair)
           (add-drum-sample (car sample-pair) (cadr sample-pair)))
         data)))

(add-drum-samples drum-sample-data)

;;; Set up e drum samples
;;;
(define add-edrum-sample
  (lambda (file-name const-name)
    (set-sampler-index edrums
                       (string-append edrum-path file-name)
                       const-name
                       0 0 0 1)))

(define edrum-sample-data
  (list
    (list "Dubstep-Kick0001.wav" 10)
    (list "Dubstep-Kick0005.wav" 11)
    (list "Dubstep-Kick0006.wav" 12)
    (list "Dubstep-Kick0007.wav" 13)
    (list "Dubstep-Kick0015.wav" 14)
    (list "Dubstep-Kick0018.wav" 15)
    (list "Dubstep-Kick0006.wav" 16)
    (list "Dubstep-Kick0007.wav" 17)
    (list "Dubstep-Kick0015.wav" 18)
    (list "Dubstep-Kick0018.wav" 19)
    (list "Dubstep-Hats0014.wav" 20)
    (list "Dubstep-Hats0017.wav" 22)
    (list "Dubstep-Hats0019.wav" 23)
    (list "Dubstep-Hats0020.wav" 24)
    (list "Dubstep-Hats0026.wav" 25)
    (list "Dubstep-Hats0039.wav" 26)
    (list "Dubstep-Cym0030.wav" 30)
    (list "Dubstep-Cym0035.wav" 31)
    (list "Dubstep-Snare0003.wav" 40)
    (list "Dubstep-Snare0008.wav" 41)
    (list "Dubstep-Snare0009.wav" 42)
    (list "Dubstep-Snare0010.wav" 43)
    (list "Dubstep-Snare0011.wav" 44)
    (list "Dubstep-Snare0013.wav" 45)
    (list "Dubstep-Snare0016.wav" 46)
    (list "Dubstep-Snare0022.wav" 47)
    (list "Dubstep-Snare0023.wav" 48)
    (list "Dubstep-Snare0025.wav" 49)
    (list "Dubstep-Snare0027.wav" 50)
    (list "Dubstep-Snare0029.wav" 51)
    (list "Dubstep-Snare0033.wav" 52)
    (list "Dubstep-Snare0036.wav" 53)
    (list "Dubstep-Snare0037.wav" 54)))


(play-note (now) edrums 12 180 44100)

(define add-edrum-samples
  (lambda (data)
    (map (lambda (sample-pair)
           (add-edrum-sample (car sample-pair) (cadr sample-pair)))
         data)))

(add-edrum-samples edrum-sample-data)


;;conga
(define add-conga-sample
  (lambda (file-name const-name)
    (set-sampler-index conga
                       (string-append conga-path file-name)
                       const-name
                       0 0 0 1)))

(define conga-sample-data
  (list
    (list "Single_Hit_01.wav" 10)
    (list "Single_Hit_02.wav" 11)
    (list "Single_Hit_03.wav" 12)
    (list "Single_Hit_04.wav" 13)
    (list "Single_Hit_05.wav" 14)
    (list "Single_Hit_06.wav" 15)
    (list "Single_Hit_07.wav" 16)
    (list "Single_Hit_08.wav" 17)
    (list "Single_Hit_09.wav" 18)
    (list "Single_Hit_10.wav" 19)
    (list "Single_Hit_11.wav" 20)
    (list "Single_Hit_12.wav" 21)
    (list "Single_Hit_13.wav" 22)
    (list "Single_Hit_14.wav" 23)
    (list "Single_Hit_15.wav" 24)))



(play-note (now) conga 24 180 44100)

(define add-conga-samples
  (lambda (data)
    (map (lambda (sample-pair)
           (add-conga-sample (car sample-pair) (cadr sample-pair)))
         data)))

(add-conga-samples conga-sample-data)


;;doumbek
(define add-doumbek-sample
  (lambda (file-name const-name)
    (set-sampler-index doumbek
                       (string-append doumbek-path file-name)
                       const-name
                       0 0 0 1)))

(define doumbek-sample-data
  (list
    (list "Doum A bell vel 4.wav" 10)
    (list "Doum B bell vel 4.wav" 11)
    (list "Doum C bell vel 4.wav" 12)
    (list "Doum mute A bell vel 4.wav" 13)
    (list "Harmonic bell vel 4.wav" 14)
    (list "Ka A bell vel 4.wav" 15)
    (list "Ka B bell vel 4.wav" 16)
    (list "Ka mute A bell vel 4.wav" 17)
    (list "Doum A head vel 4.wav" 18)
    (list "Doum B head vel 4.wav" 19)
    (list "Doum C head vel 4.wav" 20)
    (list "Doum mute A head vel 4.wav" 21)
    (list "Harmonic head vel 4.wav" 22)
    (list "Ka A head vel 4.wav" 23)
    (list "Ka B head vel 4.wav" 24)
    (list "Ka mute A head vel 4.wav" 25)
    (list "Pitch bend down bell vel 4.wav" 26)
    (list "Pitch bend down head vel 4.wav" 27)
    (list "Pitch bend up bell vel 4.wav" 28)
    (list "Pitch bend up head vel 4.wav" 29)
    (list "Rim click bell vel 4.wav" 30)
    (list "Rim click head vel 4.wav" 31)
    (list "Roll 1 bell.wav" 32)
    (list "Roll 1 head.wav" 33)
    (list "Roll 2 bell.wav" 34)
    (list "Roll 2 head.wav" 35)
    (list "Ruff bell vel 4.wav" 36)
    (list "Ruff head vel 4.wav" 37)
    (list "Slap bell vel 4.wav" 38)
    (list "Slap head vel 4.wav" 39)
    (list "Tek A bell vel 4.wav" 40)
    (list "Tek A head vel 4.wav" 41)
    (list "Tek B bell vel 4.wav" 42)
    (list "Tek B head vel 4.wav" 43)
    (list "Tek C bell vel 4.wav" 44)
    (list "Tek C head vel 4.wav" 45)
    (list "Tek mute A bell vel 4.wav" 46)
    (list "Tek mute A head vel 4.wav" 47)


    ))



(define add-doumbek-samples
  (lambda (data)
    (map (lambda (sample-pair)
           (add-doumbek-sample (car sample-pair) (cadr sample-pair)))
         data)))

(add-doumbek-samples doumbek-sample-data)
;;djembe

(define add-djembe-sample
  (lambda (file-name const-name)
    (set-sampler-index djembe
                       (string-append djembe-path file-name)
                       const-name
                       0 0 0 1)))

(define djembe-sample-data
  (list
    (list "Djembe_SingleHit01.wav" 10)
    (list "Djembe_SingleHit02.wav" 11)
    (list "Djembe_SingleHit03.wav" 12)
    (list "Djembe_SingleHit04.wav" 13)
    (list "Djembe_SingleHit05.wav" 14)
    (list "Djembe_SingleHit06.wav" 15)))
 


(play-note (now) djembe 10 180 44100)

(define add-djembe-samples
  (lambda (data)
    (map (lambda (sample-pair)
           (add-djembe-sample (car sample-pair) (cadr sample-pair)))
         data)))

(add-djembe-samples djembe-sample-data)

;;jawharp
(define add-jawharp-sample
  (lambda (file-name const-name)
    (set-sampler-index jawharp
                       (string-append jawharp-path file-name)
                       const-name
                       0 0 0 1)))

(define jawharp-sample-data
  (list
    (list "Jaw_Harp_Hit_01.wav" 10)
    (list "Jaw_Harp_Hit_02.wav" 11)
    (list "Jaw_Harp_Hit_03.wav" 12)
    (list "Jaw_Harp_Hit_04.wav" 13)
    (list "Jaw_Harp_Hit_05.wav" 14)
    (list "Jaw_Harp_Hit_06.wav" 15)
    (list "Jaw_Harp_Hit_07.wav" 16)
    (list "Jaw_Harp_Hit_08.wav" 17)
    (list "Jaw_Harp_Hit_09.wav" 18)
    (list "Jaw_Harp_Hit_10.wav" 19)
    (list "Jaw_Harp_Hit_11.wav" 20)
    (list "Jaw_Harp_Hit_12.wav" 21)
    (list "Jaw_Harp_Hit_13.wav" 22)
    (list "Jaw_Harp_Hit_14.wav" 23)
    (list "Jaw_Harp_Hit_15.wav" 24)
    (list "Jaw_Harp_Hit_16.wav" 25)
    (list "Jaw_Harp_Hit_17.wav" 26)
    (list "Jaw_Harp_Hit_18.wav" 27)
    (list "Jaw_Harp_Hit_19.wav" 28)
    (list "Jaw_Harp_Hit_20.wav" 29)
    (list "Jaw_Harp_Hit_21.wav" 30)))



(play-note (now) jawharp 30 180 44100)

(define add-jawharp-samples
  (lambda (data)
    (map (lambda (sample-pair)
           (add-jawharp-sample (car sample-pair) (cadr sample-pair)))
         data)))

(add-jawharp-samples jawharp-sample-data)


;;; Set up piano samples
;;;
(define piano-regex "^.*([ABCDEFG][#b]?[0-9])v([0-9]+)\.wav$")

(define parse-salamander-piano
  (lambda (file-list)
    (map (lambda (fname)
           (let ((result (regex:matched fname piano-regex)))
             (if (null? result)
                 #f
                 ;; load 4th velocity layer only
                 (if (= (string->number (caddr result)) 4)
                     (list fname
                           (note-name-to-midi-number (cadr result))
                           0
                           0)
                     #f))))
         file-list)))

(load-sampler
  piano
  ;; Can't use a variable here; need the actual path string
  "/Users/jasonlevine/Code/extempore/LCAD/salamander/SalamanderGrandPianoV3_44.1khz16bit/44.1khz16bit"
  ;; 'sound bank' index
  0
  parse-salamander-piano)

;;; Set up piano samples
;;;
(define guitar-regex "^.*DanElectro-Plect-RR1-([ABCDEFG][#b]?[0-9])\.wav$")

(define parse-guitar
  (lambda (file-list)
    (map (lambda (fname)
           (let ((result (regex:matched fname guitar-regex)))
             (if (null? result)
                 #f

                     (list fname
                           (note-name-to-midi-number (cadr result))
                           0
                           0)
                    )))
         file-list)))

(load-sampler
  guitar
  ;; Can't use a variable here; need the actual path string
  "/Users/jasonlevine/Code/extempore/LCAD/DanElectro-Plectrum-4RR"
  ;; 'sound bank' index
  0
  parse-guitar)


;; Now that everything is loaded, try out some notes ...
(play-note (now) doumbek 15 90 44100)
(play-note (now) drums *gm-open-hi-hat* 140 44100)
(play-note (now) piano 24 180 44100)
(play-note (now) guitar 24 100 44100)
(play-note (now) drums *gm-snare* 110 44100)
(play-note (now) epad (random 36 50) 90 (* 1.0 *second*))


