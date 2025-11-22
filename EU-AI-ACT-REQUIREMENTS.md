# EU AI Act Requirements Reference

This document provides a comprehensive overview of the EU AI Act requirements used for compliance analysis.

## Table of Contents

1. [Risk Classification](#risk-classification)
2. [Prohibited AI Practices](#prohibited-ai-practices)
3. [High-Risk AI Systems](#high-risk-ai-systems)
4. [Transparency Obligations](#transparency-obligations)
5. [Conformity Assessment](#conformity-assessment)
6. [Documentation Requirements](#documentation-requirements)
7. [Compliance Checklist](#compliance-checklist)

---

## Risk Classification

The EU AI Act classifies AI systems into four risk categories:

### 1. Unacceptable Risk (Prohibited)

**Article 5** - AI systems that pose an unacceptable risk to people's safety, livelihoods, and rights are prohibited.

**Prohibited Practices:**

1. **Subliminal manipulation** (Article 5.1.a)
   - AI systems that deploy subliminal techniques beyond consciousness to materially distort behavior
   - Causes or is likely to cause physical or psychological harm

2. **Exploitation of vulnerabilities** (Article 5.1.b)
   - Exploits vulnerabilities of specific groups (age, disability, socio-economic situation)
   - Causes or is likely to cause physical or psychological harm

3. **Social scoring** (Article 5.1.c)
   - Evaluation or classification by public authorities or on their behalf
   - Based on social behavior or personal characteristics
   - Leads to detrimental or unfavorable treatment in unrelated contexts

4. **Real-time biometric identification in public spaces** (Article 5.1.h)
   - Use by law enforcement in publicly accessible spaces
   - Exceptions for specific law enforcement purposes with strict safeguards

5. **Biometric categorization based on sensitive attributes** (Article 5.1.f)
   - Inferring race, political opinions, trade union membership, religious/philosophical beliefs, sex life, or sexual orientation
   - Exception: labeling/filtering of legally acquired biometric datasets

6. **Emotion recognition in workplace/education** (Article 5.1.g)
   - Exception: medical or safety reasons

### 2. High Risk

**Annex III** - AI systems classified as high-risk that require strict compliance:

**Categories of High-Risk AI Systems:**

1. **Biometrics** (Annex III.1)
   - Remote biometric identification systems
   - Biometric categorization systems
   - Emotion recognition systems

2. **Critical Infrastructure** (Annex III.2)
   - Safety components in managing critical digital infrastructure
   - Road traffic, water, gas, heating, electricity supply

3. **Education and Vocational Training** (Annex III.3)
   - Determining access to educational institutions
   - Assessing learning outcomes
   - Monitoring and detecting prohibited behavior during tests
   - Evaluating required competence level

4. **Employment** (Annex III.4)
   - Recruitment and selection of persons
   - Making decisions on promotion and termination
   - Task allocation and monitoring/evaluation of performance

5. **Essential Services** (Annex III.5)
   - Creditworthiness assessment
   - Credit scoring
   - Risk assessment for pricing life/health insurance
   - Emergency first response services dispatch/prioritization

6. **Law Enforcement** (Annex III.6)
   - Risk assessment for natural persons as potential victims or offenders
   - Polygraph or similar tools
   - Evaluation of reliability of evidence
   - Assessment of risk of recidivism
   - Profiling in crime investigation/prosecution

7. **Migration and Border Control** (Annex III.7)
   - Polygraph or similar tools
   - Risk assessment for security/irregular immigration
   - Verification of authenticity of travel documents
   - Examination of applications for asylum/visa

8. **Administration of Justice** (Annex III.8)
   - Assisting judicial authorities in researching and interpreting facts and law
   - Applying law to concrete facts

### 3. Limited Risk

Systems with specific transparency obligations but lower overall risk:

**Characteristics:**
- AI systems that interact with natural persons
- Emotion recognition systems (outside workplace/education)
- Biometric categorization systems
- AI-generated content (deepfakes, synthetic media)

**Requirements:**
- Clear disclosure of AI interaction (Article 52.1)
- Notification when exposed to emotion recognition (Article 52.2)
- Marking of AI-generated content (Article 52.3)
- Detection and labeling systems for deep fakes

### 4. Minimal Risk

AI systems with minimal or no risk:

**Examples:**
- AI-enabled video games
- Spam filters
- AI-powered inventory management
- Process optimization systems
- Non-sensitive recommendation systems

**Requirements:**
- Voluntary codes of conduct
- No specific legal obligations
- General product safety requirements

---

## Prohibited AI Practices

### Article 5 - Detailed Requirements

#### 5.1 Prohibition of AI Practices

The following AI practices are prohibited:

**(a) Subliminal Manipulation**
```
Placing on the market, putting into service, or using AI systems that deploy
subliminal techniques beyond a person's consciousness to materially distort
their behavior in a manner that causes or is likely to cause that person or
another person physical or psychological harm.
```

**(b) Exploitation of Vulnerabilities**
```
Placing on the market, putting into service, or using AI systems that exploit
vulnerabilities of a specific group of persons due to their age, disability, or
specific social or economic situation, to materially distort the behavior of a
person pertaining to that group in a manner that causes or is likely to cause
physical or psychological harm.
```

**(c) Social Scoring**
```
Placing on the market, putting into service, or using AI systems by public
authorities or on their behalf for the evaluation or classification of natural
persons over a certain period of time based on their social behavior or known,
inferred or predicted personal or personality characteristics, with the social
score leading to detrimental or unfavorable treatment in social contexts
unrelated or disproportionate to the contexts in which the data was collected.
```

**(d) Risk Assessment for Predictive Policing**
```
Using AI systems for making risk assessments of natural persons to assess or
predict the risk of a natural person committing a criminal offense, solely based
on profiling or assessing personality traits and characteristics (Article 5.1.d).
```

**(e) Scraping of Facial Images**
```
Placing on the market, putting into service, or using AI systems that create or
expand facial recognition databases through untargeted scraping of facial images
from the internet or CCTV footage.
```

**(f) Emotion Recognition at Work/School**
```
Placing on the market, putting into service, or using emotion recognition systems
in the workplace and educational institutions, except where the use is intended
for medical or safety reasons.
```

**(g) Biometric Categorization**
```
Placing on the market, putting into service, or using biometric categorization
systems that categorize individually natural persons based on their biometric
data to deduce or infer their race, political opinions, trade union membership,
religious or philosophical beliefs, sex life or sexual orientation.
```

**(h) Real-time Remote Biometric Identification**
```
Use of 'real-time' remote biometric identification systems in publicly accessible
spaces for law enforcement purposes, unless specific exceptions apply.
```

---

## High-Risk AI Systems

### Chapter III, Section 2 - Requirements for High-Risk AI Systems

#### Article 8 - Compliance with Requirements

High-risk AI systems must comply with all of the following requirements:

### 1. Risk Management System (Article 9)

**Requirements:**
- Establish, implement, document, and maintain a continuous risk management system
- Identify and analyze known and reasonably foreseeable risks
- Estimate and evaluate risks during intended use and foreseeable misuse
- Adopt suitable risk management measures
- Regular systematic update of risk management

**Key Elements:**
- Risk identification throughout AI system lifecycle
- Residual risk assessment
- Testing and validation
- Information for users about residual risks
- Post-market monitoring integration

### 2. Data and Data Governance (Article 10)

**Requirements:**
- Training, validation, and testing data sets shall be:
  - **Relevant**: Appropriate for the intended purpose
  - **Representative**: Cover all relevant scenarios
  - **Free of errors**: To the best extent possible
  - **Complete**: With appropriate statistical properties

**Data Governance:**
- Design choices for data collection
- Data preparation processing operations
- Formulation of assumptions (biases identified and addressed)
- Data quality checks
- Documentation of data provenance
- Protected characteristics consideration (no discrimination)

**Special Categories of Data:**
- Biometric data
- Health data
- Personal data requiring special protection

### 3. Technical Documentation (Article 11)

**Requirements:**
- Comprehensive technical documentation before placing on market
- Demonstrate compliance with all requirements
- Enable assessment by authorities

**Must Include:**
- General description of AI system
- Detailed description of system elements
- Development process details
- Monitoring, functioning and control mechanisms
- Risk management documentation
- Validation and testing procedures
- Cybersecurity measures

### 4. Record-Keeping (Article 12)

**Requirements:**
- Automatic recording of events ("logs")
- Enable traceability throughout AI system lifecycle
- Ensure level of traceability appropriate to intended purpose

**Logging Capabilities:**
- Recording period appropriate to intended purpose
- At minimum, logging of:
  - Operating period of each use
  - Reference database used
  - Input data used
  - Person verifying results (for systems under human oversight)

### 5. Transparency and Information to Users (Article 13)

**Requirements:**
- AI systems shall be designed to ensure transparency
- Accompanied by instructions for use
- Concise, complete, correct and clear information

**Information Must Include:**
- Identity and contact details of provider
- Characteristics, capabilities and limitations
- Performance metrics
- Changes and updates
- Human oversight measures
- Expected lifetime and maintenance
- Cybersecurity measures

### 6. Human Oversight (Article 14)

**Requirements:**
- High-risk AI systems designed for effective oversight
- Human oversight measures integrated during design

**Oversight Capabilities:**
- Fully understand capacities and limitations
- Remain aware of automation bias tendency
- Correctly interpret system output
- Decide not to use system or override output
- Intervene in operation or interrupt system

**Human Oversight Measures:**
- Identified before placing system on market
- Can be achieved through one or both:
  - Technical measures (stop button, control measures)
  - Organizational measures (human-in-the-loop, human-on-the-loop, human-in-command)

### 7. Accuracy, Robustness and Cybersecurity (Article 15)

**Accuracy Requirements:**
- Achieve appropriate level of accuracy
- Consistently throughout lifecycle
- Metrics declared in instructions for use
- Trade-offs between accuracy and other requirements addressed

**Robustness Requirements:**
- Resilient against:
  - Errors
  - Faults
  - Inconsistencies
  - Attempts to manipulate (adversarial attacks)

**Cybersecurity Requirements:**
- Protected against unauthorized access
- Security by design and by default
- Measures against:
  - Data poisoning attacks
  - Model evasion attacks
  - Model extraction attacks
- Regular security updates

---

## Transparency Obligations

### Article 52 - Transparency Obligations for Certain AI Systems

#### 1. AI Systems Interacting with Persons (Article 52.1)

**Requirement:**
```
Providers shall ensure that AI systems intended to interact with natural persons
are designed and developed in such a way that natural persons are informed that
they are interacting with an AI system, unless this is obvious from the
circumstances and context of use.
```

**Examples:**
- Chatbots must disclose they are AI
- Virtual assistants must identify themselves
- Customer service AI must inform users

**Exceptions:**
- When it's obvious (e.g., clearly labeled AI game character)
- Legally authorized for detecting/preventing/investigating criminal offenses

#### 2. Emotion Recognition Systems (Article 52.2)

**Requirement:**
```
Users of emotion recognition systems shall inform natural persons exposed
thereto of the operation of the system.
```

**Application:**
- Advance notification required
- Clear information about purpose
- Opt-out possibilities where applicable

**Exception:**
- Use for medical or safety purposes

#### 3. Deep Fakes and AI-Generated Content (Article 52.3)

**Requirement:**
```
Providers of AI systems that generate or manipulate image, audio or video content
('deep fakes') shall ensure that the outputs are marked in a machine-readable
format and detectable as artificially generated or manipulated.
```

**Marking Requirements:**
- Visible watermark or identifier
- Machine-readable metadata
- Disclosure in interface
- Applies to:
  - Synthetic media
  - Deep fakes
  - AI-generated content

**Exceptions:**
- Lawfully authorized for detecting/preventing/investigating criminal offenses
- Exercise of freedom of expression and arts
- When changes are not material (enhancement, restoration)

---

## Conformity Assessment

### Article 43 - Conformity Assessment

#### Internal Control Assessment (Annex VI)

For most high-risk AI systems not involving biometrics:

**Steps:**
1. Technical documentation preparation
2. Implementation of quality management system
3. Compliance verification with requirements
4. EU declaration of conformity drafting
5. CE marking affixing

#### Third-Party Assessment (Annex VII)

Required for:
- Remote biometric identification systems
- Systems listed in Annex III.1 (biometrics)

**Steps:**
1. All internal control steps
2. Submission to notified body
3. Assessment by notified body
4. Certificate issuance
5. Ongoing surveillance

---

## Documentation Requirements

### Technical Documentation (Annex IV)

Comprehensive documentation must include:

#### 1. General Description
- Intended purpose and users
- Deployment models
- General logic of AI system
- Persons/groups affected
- Reasonably foreseeable misuse

#### 2. Detailed Description
- Methods and steps for development
- Design specifications
- Architecture explanation
- Computational resources used
- Data requirements

#### 3. Data Sets
- Training data characteristics
- Validation data characteristics
- Testing data characteristics
- Data provenance information
- Data labeling procedures
- Data governance and management

#### 4. Risk Management
- Risk management plan
- Identified risks and mitigation
- Residual risks
- Post-market monitoring plan

#### 5. Testing and Validation
- Test plans and procedures
- Test results and reports
- Metrics and measurement methods
- Test data sets used

#### 6. Cybersecurity
- Security architecture
- Attack surface analysis
- Implemented security measures
- Security testing results

---

## Compliance Checklist

### For High-Risk AI Systems

#### Pre-Market Requirements

- [ ] **Risk Management System** (Article 9)
  - [ ] Continuous risk management process established
  - [ ] Known and foreseeable risks identified
  - [ ] Risk mitigation measures implemented
  - [ ] Residual risks evaluated and documented

- [ ] **Data Governance** (Article 10)
  - [ ] Training data is relevant, representative, error-free
  - [ ] Validation data set prepared
  - [ ] Testing data set prepared
  - [ ] Biases identified and addressed
  - [ ] Data provenance documented
  - [ ] Protected characteristics handled appropriately

- [ ] **Technical Documentation** (Article 11)
  - [ ] Comprehensive documentation prepared
  - [ ] All Annex IV requirements covered
  - [ ] Regular updates planned
  - [ ] Accessible for authorities

- [ ] **Record-Keeping** (Article 12)
  - [ ] Automatic logging implemented
  - [ ] Appropriate retention period defined
  - [ ] Logs capture all required events
  - [ ] Traceability ensured

- [ ] **Transparency** (Article 13)
  - [ ] Instructions for use prepared
  - [ ] Information is concise, complete, correct, clear
  - [ ] All required information included
  - [ ] Available in appropriate languages

- [ ] **Human Oversight** (Article 14)
  - [ ] Oversight measures designed and integrated
  - [ ] Human-in-the-loop/on-the-loop/in-command defined
  - [ ] Stop buttons or control measures implemented
  - [ ] Training materials for human overseers prepared

- [ ] **Accuracy, Robustness, Cybersecurity** (Article 15)
  - [ ] Accuracy metrics defined and met
  - [ ] Robustness testing completed
  - [ ] Cybersecurity measures implemented
  - [ ] Protection against attacks verified

- [ ] **Quality Management System** (Article 17)
  - [ ] QMS established and documented
  - [ ] Compliance monitoring procedures
  - [ ] Post-market monitoring system
  - [ ] Incident reporting procedures

#### Conformity Assessment

- [ ] **Internal Assessment or Third-Party** (Article 43)
  - [ ] Appropriate procedure selected
  - [ ] All assessment steps completed
  - [ ] Notified body involved (if required)
  - [ ] Certificate obtained (if required)

- [ ] **EU Declaration of Conformity** (Article 47)
  - [ ] Declaration drafted
  - [ ] All required information included
  - [ ] Signed by authorized person
  - [ ] Kept up to date

- [ ] **CE Marking** (Article 48)
  - [ ] CE marking affixed
  - [ ] Visible, legible, indelible
  - [ ] Accompanied by notified body number (if applicable)

#### Post-Market Requirements

- [ ] **Registration** (Article 49)
  - [ ] System registered in EU database
  - [ ] Registration information accurate
  - [ ] Updates submitted when required

- [ ] **Post-Market Monitoring** (Article 61)
  - [ ] Monitoring plan implemented
  - [ ] Data collected and analyzed
  - [ ] Regular reviews conducted
  - [ ] Updates made based on findings

- [ ] **Reporting** (Article 62)
  - [ ] Serious incidents reported
  - [ ] Malfunctions reported
  - [ ] Timeline requirements met
  - [ ] Corrective actions taken

- [ ] **Cooperation** (Article 63-64)
  - [ ] Authorities' requests responded to
  - [ ] Information provided upon request
  - [ ] Corrective actions implemented
  - [ ] Documentation maintained

### For Limited Risk AI Systems

- [ ] **Transparency Obligations** (Article 52)
  - [ ] AI interaction disclosed
  - [ ] Emotion recognition disclosed (if applicable)
  - [ ] AI-generated content marked (if applicable)
  - [ ] Machine-readable format implemented

### For All AI Systems

- [ ] **Prohibited Practices Check** (Article 5)
  - [ ] System does not engage in subliminal manipulation
  - [ ] System does not exploit vulnerabilities
  - [ ] System does not perform social scoring
  - [ ] System does not use prohibited biometric practices
  - [ ] System does not perform emotion recognition in prohibited contexts

---

## Common Non-Conformities

Based on compliance assessments, common issues include:

### 1. Data Governance
- Insufficient training data diversity
- Unidentified or unmitigated biases
- Incomplete data provenance documentation
- Lack of protected characteristics analysis

### 2. Documentation
- Incomplete technical documentation
- Missing risk assessments
- Inadequate testing documentation
- Unclear intended purpose definition

### 3. Transparency
- Insufficient information to users
- Unclear instructions for use
- Missing capability and limitation descriptions
- Inadequate performance metrics disclosure

### 4. Human Oversight
- Ineffective oversight measures
- Lack of human control mechanisms
- Insufficient training for human overseers
- No clear escalation procedures

### 5. Robustness & Security
- Insufficient adversarial testing
- Inadequate cybersecurity measures
- No monitoring for data drift
- Lack of update mechanisms

---

## Additional Resources

- **EU AI Act Full Text**: [EUR-Lex](https://eur-lex.europa.eu/eli/reg/2024/1689)
- **EU AI Office**: [European Commission](https://digital-strategy.ec.europa.eu/en/policies/ai-office)
- **Compliance Guidelines**: Official guidelines to be published
- **Standardization**: CEN-CENELEC standards development

---

**Version**: 1.0
**Last Updated**: 2025-11-22
**Based on**: Regulation (EU) 2024/1689

**Disclaimer**: This document is for informational purposes only and does not constitute legal advice. Always consult with qualified legal professionals for compliance matters.
